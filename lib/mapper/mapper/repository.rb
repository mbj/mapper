module Mapper
  class Mapper
    class Repository < Mapper
      def initialize(name,mappers)
        super(name)
        @mappers = mappers
      end

      def dump(object)
        data = {}
        @mappers.each do |mapper|
          data.merge!(mapper.dump(object))
        end
        data
      end

      def load(dump)
        attributes = {}

        @mappers.each do |mapper|
          attributes.merge!(mapper.load(dump))
        end

        attributes
      end
    end
  end
end
