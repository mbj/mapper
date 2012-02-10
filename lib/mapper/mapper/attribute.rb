module Mapper
  class Mapper
    class Attribute < Mapper
      attr_reader :key
      alias :key? :key

      def initialize(name,options=EMPTY_OPTIONS)
        super(name)
        @dump_name = options.fetch(:as,@name)
        @key       = !!options.fetch(:key,false)
      end
   
      def dump(object)
        { @dump_name => dump_value(object) }
      end
   
      def load(dump)
        { @name => load_value(dump) }
      end

      def load_value(dump)
        dump[@dump_name]
      end

      def dump_value(object)
        object[@name]
      end
    end
  end
end
