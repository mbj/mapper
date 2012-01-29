module Mapper
  class Mapper
    class Attribute < Mapper
      attr_reader :key
   
      def initialize(name,options=EMPTY_OPTIONS)
        super(name,options)
        @key = !!options.fetch(:key,false)
      end
   
      alias :key? :key
   
      def load(object)
        object
      end
   
      def dump(object)
        object
      end
    end
  end
end
