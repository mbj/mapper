module Mapper
  class Attribute
    # A mapper for embedded document pattern
    class EmbeddedDocument < Embedded

      def load(value)
        execute(super(value),:load)
      end

      def dump(value)
        execute(super(value),:dump)
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
