module Mapper
  module ClassMethods
    def self.extended(descendant)
      super
      create_dumper(descendant)
      create_loader(descendant)
    end

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

    def load_name(name,object)
      attributes.load_name(name,object)
    end

    def dump_name(name,object)
      attributes.dump_name(name,object)
    end

    def dump_names
      attributes.dump_names
    end

    def load_names
      attributes.load_names
    end

    def dumper_klass
      const_get(:Dumper)
    end

    def loader_klass
      const_get(:Loader)
    end

    def instanciate_model(attributes)
      model.new(attributes)
    end

    def load(dump)
      loader_klass.load(dump)
    end

    def dump(instance)
      dumper_klass.dump(instance)
    end

    def model(model = Undefined)
      if model == Undefined
        read_model
      else
        @model = model
      end
    end

    def read_model
      @model || raise("no model set for: #{self.class}")
    end

    def map(*args)
      Attribute.build(*args).tap do |attribute|
        add_attribute(attribute)
      end
    end

    def attributes
      @attributes ||= AttributeSet.new
    end

    def add_attribute(attribute)
      attributes.add(attribute)
      attribute.define_loader(loader_klass)
      attribute.define_dumper(dumper_klass)

      self
    end

    def const_missing(name)
      Attribute.determine_type(name) || super
    end
  end
end
