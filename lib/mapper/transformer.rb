module Mapper
  # Base class for loader and dumper classes
  class Transformer
    def self.mapper
      @mapper || raise("mapper setup missing")
    end

    def mapper
      self.class.mapper
    end

    def self.attributes
      mapper.attributes
    end

  private

    def __memonized__
      @__memonized__ ||= {}
    end

    def __memonize__(name)
      memonized = __memonized__
      memonized.fetch(name) do
        memonized[name]=yield
      end
    end

    class Loader < Transformer
      def initialize(dump)
        @dump = dump
        super()
      end

    protected

      def __load__(name)
        __memonize__(name) do
          mapper.load_name(name,@dump)
        end
      end

      def self.load(dump)
        loader = self.new(dump)

        attributes = {}

        self.attributes.load_names.each do |name|
          attributes[name]=loader.send(name)
        end

        mapper.model.new(attributes)
      end
    end

    class Dumper < Transformer
      attr_reader :instance

      def initialize(instance)
        @instance = instance
        super()
      end

    protected

      def __dump__(name)
        __memonize__(name) do
          mapper.dump_name(name,@instance)
        end
      end

      def self.dump(instance)
        dumper = self.new(instance)

        dump = {}

        attributes.dump_names.each do |name|
          dump[name]=dumper.send(name)
        end

        dump
      end
    end
  end
end
