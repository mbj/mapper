module Mapper
  class ModelMapper
    attr_reader :model

    def initialize(model,options={})
      @model = model
      @repository_name = options.fetch(:repository_name,nil)
      @attribute_mappers = {}
    end

    def repository_name
      if @repository_name
        @repository_name
      else
        raise "#{@model} does not have a repository name (EV?)"
      end
    end

    def dump(object)
      doc = {}
      @attribute_mappers.each_value do |map|
        doc[map.dump_name]=map.dump(object)
      end
      doc
    end

    def load(doc)
      attributes = {}
      @attribute_mappers.each_value do |map|
        attributes[map.name] = map.load(doc)
      end
      @model.new(attributes)
    end

    def attribute_mapper(attribute_mapper)
      @attribute_mappers[attribute_mapper.name] = attribute_mapper
    end

    def map_attribute(name,options={})
      attribute_mapper(AttributeMapper.new(name,options))
    end
  end
end
