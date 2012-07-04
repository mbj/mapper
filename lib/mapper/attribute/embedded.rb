class Mapper
  class Attribute
    # A base class for embedded attribute mappings
    class Embedded < Object
    private
      # Initialize attribute
      #
      # @api private
      #
      def initialize(name,options)
        @mapper = options.fetch(:mapper)
        super
      end
    end
  end
end
