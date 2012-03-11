module Mapper
  class Mapper
    class Resource < Mapper
      attr_reader :attributes

      def initialize(attributes)
        @attributes = attributes
      end

      def dump(object)
        values = {}

        @attributes.each do |mapper|
          value = mapper.dump(object)
          values.merge!(value)
        end

        values
      end

      def load(dump)
        attributes = {}

        @attributes.each do |mapper|
          attributes.merge!(mapper.load(dump))
        end

        attributes
      end

      def load_key(dump)
        dump_key(load(dump))
      end

      def dump_key(object)
        key = {}

        key_attributes.each do |mapper|
          key.merge!(mapper.dump(object))
        end

        key
      end

      def key_attributes
        @attributes.select do |attribute|
          attribute.respond_to?(:key?) && attribute.key?
        end
      end
    end
  end
end
