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
        @mapper.dump(super(object))
      end

      def load_value(dump)
        @mapper.load(super(dump))
      end
    end
  end
end
