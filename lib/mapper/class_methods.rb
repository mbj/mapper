module Mapper
  module ClassMethods

    def dump_names
      attributes.dump_names
    end

    def attribute_for_dump_name(name)
      attributes.fetch_dump_name(name)
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
