module Mapper
  # A mapped attribute
  class Attribute
    # An attribute mapped to embedded collection
    class EmbeddedCollection < Embedded
      def coerce_load(value)
        collect(value,:load)
      end

      def coerce_dump(value)
        collect(value,:dump)
      end

    private

      def collect(value,method)
        value.map do |item|
          @mapper.send(method,item)
        end
      end
    end
  end
end
