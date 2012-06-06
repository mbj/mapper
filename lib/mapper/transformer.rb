module Mapper
  # Base class for loader and dumper classes
  class Transformer
    def self.mapper
      @mapper || raise("mapper setup missing")
    end

    def mapper
      self.class.mapper
    end

  private

    def transform(names)
      names.each_with_object({}) do |name,hash|
        hash[name]=send(name)
      end
    end

    def memonize(name)
      @memonized ||= {}
      @memonized.fetch(name) do
        @memonized[name]=yield
      end
    end

    def attribute(name)
      mapper.attribute_for_dump_name(name)
    end

    # Loader base class
    class Loader < Transformer

      def loaded
        mapper = self.mapper
        attributes = transform(mapper.load_names)

        mapper.instanciate_model(attributes)
      end

    private

      def initialize(dump)
        @dump = dump
      end

      def load(name)
        memonize(name) do
          attribute(name).load(@dump)
        end
      end

    end

    # Dumper base class
    class Dumper < Transformer
      attr_reader :object

      def dumped
        transform(mapper.dump_names)
      end

    private

      def initialize(object)
        @object = object
      end

      def dump(name)
        memonize(name) do
          attribute(name).dump(@object)
        end
      end
    end
  end
end
