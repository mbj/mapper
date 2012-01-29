module Mapper
  class Mapper
    class Resource < Mapper
      attr_reader :model,:attributes

      def initialize(name,options=EMPTY_OPTIONS)
        super(name,options)
        @model = options.fetch(:model) do
          raise ArgumentError,'missing :model in +options+'
        end
        @attributes = options.fetch(:attributes) do
          raise ArgumentError,'missing :attributes in +options+'
        end
      end
   
      def dump(object)
        values = {}
   
        @attributes.each do |attribute|
          value =attribute.dump(object.send(attribute.name))
          values[attribute.dump_name] = value
        end

        values
      end
   
      def load(object)
        data = {}
   
        @attributes.each do |attribute|
          value = attribute.load(object[attribute.dump_name])
          data[attribute.name] = value
        end

        @model.new(data)
      end
    end
  end
end
