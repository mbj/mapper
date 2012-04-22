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

      def to_dump(value)
        if value
          @mapper.dump(value)
        end
      end

      def from_dump(value)
        if value
          @mapper.load(value)
        end
      end
    end
  end
end
