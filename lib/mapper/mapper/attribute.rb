module Mapper
  class Mapper
    class Attribute < Mapper
      def initialize(name,options=EMPTY_OPTIONS)
        super(name)
        @dump_name = options.fetch(:as,@name)
      end
   
      def dump(object)
        { @dump_name => dump_value(object) }
      end
   
      def load(object)
        { @name => load_value(object) }
      end

      def load_value(object)
        object[@dump_name]
      end

      def dump_value(object)
        object[@name]
      end
    end
  end
end
