module Mapper
  class Mapper
    class EmbeddedDocument < Attribute
      def initialize(name,options)
        super(name,options)
        @mapper = options.fetch(:mapper) do
          raise ArgumentError,'missing :mapper in +options+'
        end

        def dump_value(object)
          value = super(object)
          @mapper.dump(value)
        end

        def load_value(object)
          value = super(object)
          @mapper.load(value)
        end
      end
    end
  end
end
