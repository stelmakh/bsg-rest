require 'time'
require_relative 'base'

module BSG
  class HLR < BSG::Base
    attr_accessor :error, :msisdn, :reference, :price, :result, :totalprice,
                  :currency, :id, :network, :status, :details, :createdDatetime,
                  :statusDatetime, :name_ru, :name_en, :brand, :name, :prices, :errorDescription, 
                  :tariff_code

    def createdDatetime=(value)
      @createdDatetime = value_to_time(value)
    end

    def statusDatetime=(value)
      @statusDatetime = value_to_time(value)
    end
  end
end
