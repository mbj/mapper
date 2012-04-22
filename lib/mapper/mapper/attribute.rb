module Mapper
  class Mapper
    class Attribute < Mapper
      attr_reader :name, :dump_name


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
        from_dump(dump[@dump_name])
      end

      def dump_value(object)
        to_dump(object[@name])
      end

      def from_dump(value); value; end
      def to_dump(value); value; end
    end
  end
end
