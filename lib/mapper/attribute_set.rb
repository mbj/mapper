module Mapper
  class AttributeSet
    extend Forwardable
    def_delegators :@set,:each,:map

    def initialize()
      @set = Set.new
    end

    def add(attribute)
      @set << attribute
      reset

      self
    end

    def dump_map
      @dump_map ||= 
        begin
          map = {}
          each do |attribute|
            attribute.add_to_dump_map(map)
          end
          map
        end
    end

    def dump_names
      dump_map.keys
    end

    def load_names
      load_map.keys
    end

    def load_map 
      @load_map ||=
        begin
          map = {}
          each do |attribute|
            attribute.add_to_load_map(map)
          end
          map
        end
    end

  protected

    def reset
      @dump_map = @load_map = nil
      self
    end
  end
end
