module Mapper
  class Mapper
    class Resource < Mapper
      def initialize(name,options=EMPTY_OPTIONS)
        super(name)
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
          name = attribute.name
          values[name] = attribute.dump(object.send(name))
        end
   
        values
      end
   
      def load(object)
        data = {}
   
        @attributes.each do |attribute|
          name = attribute.name
          data[name] = attribute.load(object[name])
        end

        @model.new(data)
      end
    end
  end
end
