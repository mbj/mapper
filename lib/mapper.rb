require 'mapper/version'

require 'mapper/mapper'
require 'mapper/mapper/resource'
require 'mapper/mapper/attribute'
require 'mapper/mapper/embedded_collection'
require 'mapper/mapper/embedded_document'
require 'mapper/mapper/embedded_value'
require 'mapper/mapper/root'

module Mapper
  # Create a deep copy of an object
  #
  # @param [Object] value
  #
  # @return deep copy of value
  #
  def self.deep_copy(value)
    Marshal.load(Marshal.dump(value))
  end
end
