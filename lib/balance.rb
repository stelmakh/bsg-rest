require 'time'
require_relative 'base'

module BSG
  class BALANCE < BSG::Base
    attr_accessor :error,:errorDescription, :currency, :amount, :limit

    def createdDatetime=(value)
      @createdDatetime = value_to_time(value)
    end

    def statusDatetime=(value)
      @statusDatetime = value_to_time(value)
    end
  end
end
