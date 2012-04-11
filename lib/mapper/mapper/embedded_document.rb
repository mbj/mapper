module Mapper
  class Mapper
    class EmbeddedDocument < Attribute
      def initialize(name,options)
        super(name,options)
        @mapper = options.fetch(:mapper) do
          raise ArgumentError,'missing :mapper in +options+'
        end
      end

    protected

      def dump_value(object)
        value = super(object)
        if value
          @mapper.dump(value)
        end
      end

      def load_value(dump)
        value = super(dump)
        if value
          @mapper.load(value)
        end
      end
    end
  end
end
