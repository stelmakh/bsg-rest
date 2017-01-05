require 'json'
require 'uri'
require 'rest-client'
require_relative 'error'
require_relative 'hlr'
require_relative 'message'

module BSG
  class ErrorException < StandardError
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end
  end
  ENDPOINT = 'http://5.178.83.12'
  class Client
      attr_reader :access_key

      def initialize(access_key = nil)
        @access_key = access_key || ENV['BSG_ACCESS_KEY']
      end

      def request(method, path, params={})
        url = URI.join(ENDPOINT, '/rest/', path).to_s

        # Set up the HTTP object.
        headers = {:content_type => 'application/json', 'X-API-KEY' => "#{@access_key}"}
        playload = params.to_json if method == :post && !params.empty?
        
        # Construct the HTTP GET or POST request.
        response = RestClient.get(url, headers)  if method == :get
        response = RestClient.post(url, "#{playload}", headers) if method == :post

        # Parse the HTTP response.
        case response.code.to_i
        when 200, 201, 204, 401, 404, 405, 422
          json = JSON.parse(response.body)
        else
          raise Net::HTTPServerError.new response.http_version, 'Unknown response from server', response
        end

        # If the request returned errors, create Error objects and raise.
        if json['error'].to_i != 0
          raise ErrorException, [json].map { |e| Error.new(e) }
        end

        json
      end

      # =============================
      #         BSG HLR API
      # =============================

      # Retrieve the information of specific HLR.
      def hlr(id)
        HLR.new(request(:get, "hlr/#{id.to_s}"))
      end

      # Retrieve the information of specific HLR by Reference.
      def hlr_reference(reference)
        HLR.new(request(:get, "hlr/reference/#{reference.to_s}"))
      end

      # Create a new HLR.
      def hlr_create(params={})
          HLR.new(request(
            :post,
            "hlr/create/",
            if params.kind_of? Array
              params
            else
              [] << params.merge({})
            end
          ))

      end

      # Retrieve the prices of specific HLR tariff.
      def hlr_prices(tariff=nil)
        if tariff.nil?
          HLR.new(request(:get, "hlr/prices"))
        else
          HLR.new(request(:get, "hlr/prices/#{tariff.to_s}"))
        end
      end
      # =============================
      #         BSG SMS API
      # =============================

      # Retrieve the prices of specific SMS tariff.
      def message_prices(tariff=nil)
        if tariff.nil?
          MESSAGE.new(request(:get, "sms/prices/"))
        else
          MESSAGE.new(request(:get, "sms/prices/#{tariff.to_s}"))
        end
      end
      # Retrieve the information of specific SMS.
      def message(id)
        MESSAGE.new(request(:get, "sms/#{id.to_s}"))
      end
      # Retrieve the information of specific SMS task.
      def message_task(task_id)
        MESSAGE.new(request(:get, "sms/task/#{task_id.to_s}"))
      end

      # Create a new SMS.
      def message_create(params={})
        MESSAGE.new(request(:post, "sms/create/",
          params.merge({})
        ))
      end

  end
end
