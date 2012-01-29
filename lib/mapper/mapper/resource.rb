module Mapper
  class Mapper
    class Resource < Mapper
      def initialize(name,model,attributes)
        super(name)
        @model = model
        @attributes = attributes
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
