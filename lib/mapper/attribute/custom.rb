class Mapper
  # A mapped attribute
  class Attribute
    # A mapper attribute with custom behaviour
    class Custom < Object
      # Return field names in dump this attribute creates
      #
      # @return [Array<Symbol>]
      #
      # @api private
      #
      attr_reader :dump_names

      # Define attribute loader on class
      #
      # Noop for this attribute.
      #
      # @param [Class] klass
      #
      # @return [self]
      #
      # @api private
      #
      def define_loader(klass)
        self
      end

      # Define attribute dumper on class
      #
      # Noop for this attribute.
      #
      # @param [Class] klass
      #
      # @return [self]
      #
      # @api private
      #
      def define_dumper(klass)
        self
      end

    private

      # Initialize attribute
      #
      # @api private
      def initialize(name, options={})
        @load_name = name
        @dump_names = Array(options.fetch(:to, name))
      end
    end
  end
end
