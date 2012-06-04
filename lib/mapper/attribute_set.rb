module Mapper
  # A set of mapping attributes
  class AttributeSet
    def initialize()
      @set = Set.new
    end

    def add(attribute)
      @set << attribute
      reset

      self
    end

    def dump_map
      @dump_map ||= collect(:add_to_dump_map)
    end

    def load_map 
      @load_map ||= collect(:add_to_load_map)
    end

    def dump_names
      dump_map.keys
    end

    def load_names
      load_map.keys
    end

    def load_name(name,dump)
      fetch(name).load(dump)
    end

    def dump_name(name,object)
      fetch(name).dump(object)
    end

  private

    def fetch(name)
      dump_map.fetch(name)
    end

    def collect(method)
      @set.each_with_object({}) do |attribute,map|
        attribute.send(method,map)
      end
    end


    def reset
      @dump_map = @load_map = nil
      self
    end
  end
end
