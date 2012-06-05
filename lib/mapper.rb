require 'backports'
require 'virtus'

module Mapper
  Undefined = Object.new.freeze

  def self.included(descendant)
    descendant.extend(ClassMethods)
    create_dumper(descendant)
    create_loader(descendant)
  end

private

  def self.create_dumper(descendant)
    klass = Class.new(Transformer::Dumper)
    set_mapper(klass,descendant)
    klass.instance_variable_set(:@mapper,descendant)
    descendant.const_set(:Dumper,klass)
  end

  def self.create_loader(descendant)
    klass = Class.new(Transformer::Loader)
    set_mapper(klass,descendant)
    descendant.const_set(:Loader,klass)
  end

  def self.set_mapper(klass,mapper)
    klass.instance_variable_set(:@mapper,mapper)
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
