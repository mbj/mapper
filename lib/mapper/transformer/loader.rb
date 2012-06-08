module Mapper
  class Transformer
    # Loader base class
    class Loader < Transformer
      # Return loaded domain object
      #
      # @return [Object]
      #
      # @api private
      #
      def object
        @object ||= mapper.instanciate_model(attributes)
      end

      # Return loaded attributes
      #
      # @return [Hash]
      #
      # @api private
      #
      def attributes
        @attributes ||= map(attribute_set.load_names)
      end

    private

      # Initalize Loader
      #
      # @param [Object] dump
      # @return [undefined]
      # @api private
      #
      def initialize(dump)
        super(mapper::DumpWrapper.new(dump),:load)
      end
    end
  end
end
