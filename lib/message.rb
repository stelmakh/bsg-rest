require 'time'
require_relative 'base'

module BSG
  class MESSAGE < BSG::Base
    attr_accessor :error, :msisdn, :reference, :price, 
                  :destination, :id, :originator, :body, :validity, :phones,
                  :task_id, :totalprice, :currency

    def createdDatetime=(value)
      @createdDatetime = value_to_time(value)
    end

    def statusDatetime=(value)
      @statusDatetime = value_to_time(value)
    end
  end
end
