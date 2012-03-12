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

  def self.fetch_option(options,key)
    options.fetch(key) do
      raise ArgumentError.new("missing #{key.inspect} in +options+")
    end
  end

  def self.convert_keys(input,method)
    output = {}
    return input unless input.kind_of?(Hash)
    input.each do |key,value|
      new_value =
        case value
        when Hash
          convert_keys(value,method)
        when Array
          value.map { |item| convert_keys(item,method) }
        else
          value
        end
      output[key.send(method)] = new_value
    end
    output
  end

  def self.stringify_keys(input)
    convert_keys(input,:to_s)
  end

  def self.symbolize_keys(input)
    convert_keys(input,:to_sym)
  end
end
