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
   
      def to_dump(value)
        if value
          value.map do |item|
            @mapper.dump(item)
          end
        end
      end
   
      def from_dump(value)
        if value
          value.map do |item|
            @mapper.load(item)
          end
        end
      end
    end
  end
end
