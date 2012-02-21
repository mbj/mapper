module Mapper
  class Mapper
    class EmbeddedCollection < Attribute
      attr_reader :mapper

      def initialize(name,options)
        super(name)
        @mapper = options.fetch(:mapper) do 
          raise ArgumentError,'missing :mapper in +options+'
        end
      end
   
      def dump_value(object)
        value = super(object)
        if value
          value.map do |item|
            @mapper.dump_value(item)
          end
        end
      end
   
      def load_value(object)
        value = super(object)
        if value
          value.map do |item|
            @mapper.load_value(item)
          end
        end
      end
    end
  end
end
