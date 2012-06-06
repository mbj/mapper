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

    private

      def coerce_dump(value)
        raise_error("#coerce_dump")
      end

      def coerce_load(value)
        raise_error("#coerce_load")
      end

      def raise_error(method)
        raise NotImplementedError,"#{self.class.inspect}#{method} must be implemented"
      end
    end
  end
end
