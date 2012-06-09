require 'backports'
require 'virtus'

module Mapper
  Undefined = Object.new.freeze

  # Callback when ::Mapper is included into namespace
  #
  # @return [undefined]
  #
  # @api private
  #
  def self.included(descendant)
    descendant.extend(ClassMethods)
    descendant.send(:setup)

    super
  end

  # Construct a mapper
  #
  # @return [Class<Mapper>]
  #
  # @api private
  #
  def self.new(&block)
    klass = new_mapper
    klass.send(:class_eval,&block) if block
    klass
  end

  # Constrinct an empty mapper
  #
  # @return [Class<Mapper>]
  #
  # @api private
  #
  def self.new_mapper
    Class.new do
      include ::Mapper
    end
  end
end

require 'mapper/reader_definer'
require 'mapper/dump_wrapper'
require 'mapper/class_methods'
require 'mapper/transformer'
require 'mapper/transformer/loader'
require 'mapper/transformer/dumper'
require 'mapper/attribute'
require 'mapper/attribute/object'
require 'mapper/attribute/embedded'
require 'mapper/attribute/embedded_document'
require 'mapper/attribute/embedded_collection'
require 'mapper/attribute/custom'
require 'mapper/attribute_set'
require 'mapper/attribute_set/operations'
