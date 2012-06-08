module Mapper
  module ClassMethods
    # Return names of fields in dump
    #
    # @return [Array]
    #
    # @api private
    #
    def dump_names
      attributes.dump_names
    end

    # Return names of attributes in loaded objects
    #
    # @return [Array]
    #
    # @api private
    #
    def load_names
      attributes.load_names
    end

    # Return attribute that handles dump name
    #
    # @return [Attribute]
    #
    # @api private
    #
    def attribute_for_dump_name(name)
      attributes.fetch_dump_name(name)
    end

    # Instanciates a mapped model from attribues
    #
    # @param [Objec] attributes
    #
    # @return [Object]
    #
    # @api private
    #
    def instanciate_model(attributes)
      model.new(attributes)
    end

    # Load domain object from dump
    #
    # @param [Object] dump
    #
    # @return [Object]
    #
    # @api private
    #
    def load(dump)
      loader_klass.new(dump).loaded
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
      dumper_klass.new(object).dumped
    end

    # Return attributes mapper is handling
    #
    # @return [AttributeSet]
    #
    # @api private
    #
    def attributes
      @attributes ||= AttributeSet.new
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
    def wrap_query(*)
      raise NotImplementedError,'::Mapper does not implement queries. See DB/query-system specific mappers'
    end

  private

    # Set or return mappers model
    #
    # @example 
    #   class Person
    #     attribute :firstname,String
    #     class Mapper
    #       include ::Mapper
    #       model(Person)
    #     end
    #   end
    #
    # @return [Model]
    #
    # @param [Model] model
    #    when given the model is stored for mapper
    #
    # @raise [RuntimeError] 
    #    when no model is provided in args and no model was set before
    #
    # @api private
    #
    def model(model = Undefined)
      if model == Undefined
        read_model
      else
        @model = model
      end
    end

    # Declare a mapping between attribute and database
    #
    # @param [Symbol] name
    #   the name of the attribute
    #
    # @param [Class] klass
    #   the klass of the mapping
    #
    # @param [Options] options
    #   the options for this mapping
    #
    # @return [self]
    #
    # @api private
    #
    def map(name,klass,options={})
      attribute = Attribute.build(name,klass,options)
      add_attribute(attribute)

      self
    end

    # Lookup a missing mapping constant
    #
    # @return [Class]
    #
    # @api private
    #
    def const_missing(name)
      Attribute.determine_type(name) || super
    end

    # Add attribute to mapper
    #
    # @param [Attribute] attribute
    #
    # @return [self]
    #
    # @api private
    #
    def add_attribute(attribute)
      attributes.add(attribute)
      attribute.define_loader(loader_klass)
      attribute.define_dumper(dumper_klass)

      self
    end

    # Return mappers dumper class
    #
    # @return [Class<Dumper>]
    #
    # @api private
    #
    def dumper_klass
      const_get(:Dumper)
    end

    # Return mappers dumper class
    #
    # @return [Class<Loader>]
    #
    # @api private
    #
    def loader_klass
      const_get(:Loader)
    end

    # Read mappers model or raise
    #
    # @return [Model]
    #
    # @api private
    #
    def read_model
      @model || raise("no model set for: #{self.class}")
    end

    # Create mappers dumper and loader class 
    #
    # @return [self]
    #
    # @api private
    #
    def setup
      create(Transformer::Dumper,:Dumper)
      create(Transformer::Loader,:Loader)

      self
    end

    # Create a mappers transformation class
    #
    # @return [self]
    #
    # @api private
    #
    def create(klass,name)
      klass = Class.new(klass)
      klass.instance_variable_set(:@mapper,self)
      const_set(name,klass)

      self
    end
  end
end
