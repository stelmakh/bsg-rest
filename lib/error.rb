require_relative 'base'

module BSG
  class Error < BSG::Base
    attr_accessor :error, :errorDescription
  end
end