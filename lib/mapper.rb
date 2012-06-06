require 'backports'
require 'virtus'

module Mapper
  Undefined = Object.new.freeze

  def self.included(descendant)
    descendant.extend(ClassMethods)
    descendant.send(:setup)

    super
  end

  def self.new(&block)
    klass = new_mapper_class
    klass.send(:class_eval,&block) if block
    klass
  end

  def self.new_mapper_class
    Class.new do
      include ::Mapper
    end
  end
end

require 'mapper/class_methods'
require 'mapper/transformer'
require 'mapper/attribute'
require 'mapper/attribute/object'
require 'mapper/attribute/embedded'
require 'mapper/attribute/embedded_document'
require 'mapper/attribute/embedded_collection'
require 'mapper/attribute/custom'
require 'mapper/attribute_set'
