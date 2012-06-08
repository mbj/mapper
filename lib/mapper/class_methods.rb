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

    def instanciate_model(attributes)
      model.new(attributes)
    end

    def load(dump)
      loader_klass.new(dump).loaded
    end

    def dump(instance)
      dumper_klass.new(instance).dumped
    end

    def attributes
      @attributes ||= AttributeSet.new
    end

    def wrap_query(*)
      raise NotImplementedError,'::Mapper does not implement queries. See DB/query-system specific mappers'
    end

  private

    def model(model = Undefined)
      if model == Undefined
        read_model
      else
        @model = model
      end
    end

    def map(*args)
      attribute = Attribute.build(*args)
      add_attribute(attribute)

      self
    end

    def const_missing(name)
      Attribute.determine_type(name) || super
    end

    def add_attribute(attribute)
      attributes.add(attribute)
      attribute.define_loader(loader_klass)
      attribute.define_dumper(dumper_klass)

      self
    end

    def dumper_klass
      const_get(:Dumper)
    end

    def loader_klass
      const_get(:Loader)
    end

    def read_model
      @model || raise("no model set for: #{self.class}")
    end

    def setup
      create(Transformer::Dumper,:Dumper)
      create(Transformer::Loader,:Loader)

      self
    end

    def create(klass,name)
      klass = Class.new(klass)
      klass.instance_variable_set(:@mapper,self)
      const_set(name,klass)

      self
    end
  end
end
