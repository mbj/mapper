module Mapper
  # Mongo specific mapper for storing references 
  class ReferenceMapper < ::Mapper::AttributeMapper
    def initialize(name,model,options={})
      options[:dump_name] ||= :"#{name}_id"
      super(name, options)
      @model = model
    end

    def load(object)
      value = super(object)
      case value
      when NilClass
        nil
      when BSON::ObjectId
        Mapper.current_db_session.first(@model,:_id => value)
      else
        raise
      end
    end

    def dump(object)
      value = super(object)
      case value
      when NilClass
        nil
      when value
        session = Mapper.current_db_session
        unless session.loaded?(value)
          raise "cannot save a unloaded reference to: #{value.inspect}"
        end
        value.id
      else
        raise
      end
    end
  end
end
