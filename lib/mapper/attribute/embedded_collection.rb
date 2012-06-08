module Mapper
  # A mapped attribute
  class Attribute
    # An attribute mapped to embedded collection
    class EmbeddedCollection < Embedded

      def load(value)
        collect(super(value),:load)
      end

      def dump(value)
        collect(super(value),:dump)
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
