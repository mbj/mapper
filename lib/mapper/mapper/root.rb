module Mapper
  class Mapper
    class Root < Mapper
      def initialize(name,mappers)
        super(name)

        @mappers = mappers
      end

      def dump(object)
        data = {}
        @mappers.each do |repository|
          data[repository.name] = repository.dump(object)
        end
        data
      end

      def load(dump)
        attributes = {}
        @mappers.each do |repository|
          repo = dump[repository.name]
          if repo
            data = repository.load(repo)
            attributes.merge!(data)
          end
        end
        attributes
      end
    end
  end
end
