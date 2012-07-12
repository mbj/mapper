class Mapper
  class Veritas < Mapper
    # Reader for veritas mapped relations
    class Reader
      include Enumerable

      # Enumerate loaders
      #
      # @return [self]
      #
      # @api private
      #
      def each
        return to_enum(__method__) unless block_given?

        @relation.each do |tuple|
          yield @mapper.loader(tuple)
        end

        self
      end

    private

      # Initialize reader
      #
      # @param [Mapper] mapper
      # @param [Veritas::Relation] relation
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(mapper, relation)
        @mapper, @relation = mapper, relation
      end

      # Handle method missing messages
      #
      # @param [Symbol] method
      #
      # @return [Object]
      #
      # @api private
      #
      def method_missing(method, *args, &block)
        forwardable?(method) ? forward(method, args, &block) : super
      end

      # Forward message to relation
      #
      # @param [Symbol] method
      # @param [Array] args
      #
      # @return [Object]
      #
      # @api private
      #
      def forward(method, args, &block)
        result = @relation.send(method, *args, &block)

        unless result.kind_of?(::Veritas::Relation)
          return result
        end

        self.class.new(@mapper, result)
      end

      # Check if method is forwardable
      #
      # @param [Symbol] method
      #
      # @return [true]
      #   returns true if method is forwardable
      # @return [false]
      #   returns false if method is NOT forwardable
      #
      # @api private
      #
      def forwardable?(method)
        @relation.respond_to?(method)
      end
    end
  end
end
