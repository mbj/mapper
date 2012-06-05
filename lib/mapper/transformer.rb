module Mapper
  # Base class for loader and dumper classes
  class Transformer
    def self.mapper
      @mapper || raise("mapper setup missing")
    end

    def self.transfer(names,transformator)
      names.each_with_object({}) do |name,hash|
        hash[name]=transformator.send(name)
      end
    end


  private

    def mapper
      self.class.mapper
    end

    def memonize(name)
      @memonized ||= {}
      @memonized.fetch(name) do
        @memonized[name]=yield
      end
    end

    # Loader base class
    class Loader < Transformer
      def initialize(dump)
        @dump = dump
        super()
      end

    private

      def load(name)
        memonize(name) do
          mapper.load_name(name,@dump)
        end
      end

      def self.load(dump)
        mapper = self.mapper

        loader = self.new(dump)

        attributes = transfer(mapper.load_names,loader)

        mapper.instanciate_model(attributes)
      end
    end

    # Dumper base class
    class Dumper < Transformer
      attr_reader :object

      def initialize(object)
        @object = object
      end

    private

      def dump(name)
        memonize(name) do
          mapper.dump_name(name,@object)
        end
      end

      def self.dump(object)
        dumper = self.new(object)

        transfer(self.mapper.dump_names,dumper)
      end
    end
  end
end
