module Mapper
  class Mapper
    class Attribute < Mapper
      attr_reader :name


      def initialize(name,options={})
        @name      = name
        @dump_name = options.fetch(:as,@name)
        @key       = !!options.fetch(:key,false)
      end

      def key?; @key; end
   
      def dump(object)
        { @dump_name => dump_value(object) }
      end
   
      def load(dump)
        { @name => load_value(dump) }
      end

    protected

      def load_value(dump)
        dump[@dump_name]
      end

      def dump_value(object)
        object[@name]
      end
    end
  end
end
