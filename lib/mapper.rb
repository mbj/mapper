require 'forwardable'
require 'virtus'
require 'pp'
require 'rspec'

module Mapper
  Undefined = Object.new.freeze

  def self.included(descendant)
    descendant.extend(ClassMethods)
  end
end

require 'mapper/class_methods'
require 'mapper/transformer'
require 'mapper/attribute'
require 'mapper/attribute_set'
