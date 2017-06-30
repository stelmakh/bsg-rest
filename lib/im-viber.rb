require 'time'
require_relative 'base'

module BSG
  class VIBER < BSG::Base
    attr_accessor :result, :totalprice, :currency

    def createdDatetime=(value)
      @createdDatetime = value_to_time(value)
    end

    def statusDatetime=(value)
      @statusDatetime = value_to_time(value)
    end
  end
end
