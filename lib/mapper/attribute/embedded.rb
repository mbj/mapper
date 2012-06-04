module Mapper
  class Attribute
    # A base class for embedded attribute mappings
    class Embedded < Object
      def initialize(name,options)
        @mapper ||= options.fetch(:mapper)
        super
      end

      def dump(instance)
        coerce_dump(super)
      end

      def load(dump)
        coerce_load(super)
      end
    end
  end
end
