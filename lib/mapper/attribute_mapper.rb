module Mapper
  class AttributeMapper
    attr_reader :name
    attr_reader :dump_name
    
    def initialize(name,options={})
      @name = name
      @dump_name = options.fetch(:dump_name,@name).to_s
      @dump    = options.fetch(:dump,:value)
      @load    = options.fetch(:load,:value)
    end
    
    def dump(object)
      value = object.send(@name)
      case @dump
      when Proc
        @dump.call(value)
      when :value
        value
      else
        raise "illegal dump: #{@dump.inspect}"
      end
    end
    
    def load(doc)
      dumped = doc[dump_name]
      case @load
      when Proc
        @load.call(dumped)
      when :value
        dumped
      else
        raise "illegal load: #{@load.inspect}"
      end
    end
  end
end
