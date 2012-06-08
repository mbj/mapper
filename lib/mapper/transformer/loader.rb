module Mapper
  class Transformer
    # Loader base class
    class Loader < Transformer
      # Return loaded domain object
      #
      # @return [DomainObject]
      #
      # @api private
      #
      def loaded
        mapper = self.mapper
        attributes = collect(mapper.load_names)

        mapper.instanciate_model(attributes)
      end

      private

      # Initialize loader with dumped representation
      #
      # @param [Object] dump
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(dump)
        @dump = dump
      end

      # Access domain object attribute with name
      #
      # @param [Symbol] name
      #
      # @return [Object]
      #
      # @api private
      #
      def load(name)
        memonize(name) do
          attribute(name).load(@dump)
        end
      end
    end
  end
end
