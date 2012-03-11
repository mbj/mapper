module Mapper
  class Mapper
    class EmbeddedValue < Attribute
      def initialize(name,options)
        super(name,options)
        @mapper = options.fetch(:mapper) do
          raise ArgumentError,'missing :mapper in +options+'
        end
      end

      def dump(object)
        values = {}
        value = dump_value(object)

        @mapper.dump(value).each do |key,value|
          values[attribute_name(key)]=value
        end

        values 
      end

      def attribute_name(key)
        :"#{@dump_name}_#{key}"
      end

      def load_value(object)
        values = {}

        @mapper.attributes.each do |attribute|
          name = attribute.name
          values[name]=object[attribute_name(name)]
        end

        values
      end
    end
  end
end
