module Mapper
  class Mapper
    class Attribute < Mapper
      attr_reader :key
   
      def initialize(name,key=false)
        super(name)
        @key = !!key
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
