module Mapper
  class Mapper
    class Resource < Mapper
      attr_reader :mappers

      def initialize(name,mappers)
        super(name)
        @mappers = mappers
      end
   
      def dump(object)
        { @name => dump_value(object) }
      end

      def dump_value(object)
        values = {}

        @mappers.each do |mapper|
          value = mapper.dump(object)
          values.merge!(value)
        end

        values
      end

      def load_value(dump)
        attributes = {}

        @mappers.each do |mapper|
          attributes.merge!(mapper.load(dump))
        end

        attributes
      end
   
      def load(dump)
        load_value(dump.fetch(@name,{}))
      end
    end
  end
end
