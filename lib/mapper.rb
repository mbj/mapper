require 'backports'
require 'virtus'

# Library namespace and abstract root mapper class
class Mapper
  Undefined = Object.new.freeze

  # Load domain object from dump
  #
  # @param [Object] dump
  #
  # @return [Object]
  #
  # @api private
  #
  def load(dump)
    loader(dump).object
  end

  # Create a loader instance for dump
  #
  # @param [Object] dump
  #   the dump to load
  #
  # @return [Mapper::Transformer::Loader]
  #
  # @api private
  def loader(dump)
    loader_class.new(self,dump)
  end

  # Transform domain object into dump
  #
  # @param [Object] object
  #   the domain object to dump
  #
  # @return [Object]
  #
  # @api private
  #
  def dump(object)
    dumper(object).dump
  end

  # Create a dumper instance for domain object
  #
  # @param [Object] object
  #   the domain object to dump
  #
  # @return [Mapper::Transformer::Dumper]
  #
  # @api private
  #
  def dumper(object)
    dumper_class.new(self,object)
  end

  # Return attributes of this mapper 
  #
  # @return [AttributeSet]
  #
  # @api private
  #
  def attributes
    @attributes 
  end

  # Return model of this mappe
  #
  # @return [Object]
  #   returns the model this mapper maps to
  #
  # @api private
  #
  def model
    @model
  end

  # Wrap a query into reader object
  #
  # This is handled by specialized adpaters. 
  #
  # @raise [NotImplentedError]
  #   when called on ::Mapper
  #
  # @api private
  #
  # @return [Reader]
  #
  def reader(*)
    raise NotImplementedError,"#{self.class}#reader must be implemented"
  end

  # Build a new mapper using the dsl
  #
  # @example
  #   class Person
  #     attr_reader :firstname
  #
  #     def initialize(firstname)
  #       @firstname = firstname
  #     end
  #
  #     Mapper = ::Mapper.build(self) do
  #       map :firstname, Attribute
  #     end
  #   end
  #
  # @param [Object] model
  #   the model to build mapper for
  #
  # @return [Mapper]
  #   the initialized mapper instance
  #
  # @api private
  #
  def self.build(model,&block)
    Builder.run(self,model,&block)
  end

private

  # Initialize mapper
  #
  # @param [Object] model
  # @param [AttributeSet] attributes
  #
  # @return [undefined]
  #
  # @api private
  #
  def initialize(model,attributes)
    @model,@attributes = model, attributes
  end

  # Return the loader class
  #
  # @return [Class]
  #
  # @api private
  #
  def loader_class
    attributes.loader_class
  end

  # Return the dumper class
  #
  # @return [Class]
  #
  # @api private
  #
  def dumper_class
    attributes.dumper_class
  end
end

require 'mapper/builder'
require 'mapper/reader_definer'
require 'mapper/document'
require 'mapper/document/dump_wrapper'
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
