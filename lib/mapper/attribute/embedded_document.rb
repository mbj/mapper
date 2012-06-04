module Mapper
  class Attribute
    # A mapper for embedded document pattern
    class EmbeddedDocument < Embedded
      def coerce_load(value)
        execute(value,:load)
      end

      def coerce_dump(value)
        execute(value,:dump)
      end

    private

      def execute(value,method)
        unless value.nil?
          @mapper.send(method,value)
        end
      end
    end
  end
end
