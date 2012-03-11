module Mapper
  class Mapper
    class EmbeddedCollection < Attribute
      attr_reader :mapper

      def initialize(name,options)
        super(name,options)
        @mapper = options.fetch(:mapper) do 
          raise ArgumentError,'missing :mapper in +options+'
        end
      end

    protected
   
      def dump_value(object)
        value = super(object)
        if value
          value.map do |item|
            @mapper.dump(item)
          end
        end
      end
   
      def load_value(dump)
        value = super(dump)
        if value
          value.map do |item|
            @mapper.load(item)
          end
        end
      end
    end
  end
end
