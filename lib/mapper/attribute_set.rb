module Mapper
  # A set of mapping attributes
  class AttributeSet
    def initialize()
      @set = Set.new
    end

    def empty?
      @set.empty?
    end

    def add(attribute)
      @set << attribute
      reset

      self
    end

    def dump_names
      dump_map.keys
    end

    def load_names
      @load_names ||=
        @set.each_with_object([]) do |attribute,names|
          names.concat(attribute.load_names)
        end
    end
    
    def fetch_dump_name(name)
      dump_map.fetch(name) do
        raise ArgumentError,"no attribute with dump name of #{name.inspect} does exist"
      end
    end

  private

    def dump_map
      @dump_map ||= 
        Hash[
          @set.each_with_object([]) do |attribute,entries|
            entries.concat(attribute.dump_names.product([attribute]))
          end
        ]
    end

    def reset
      @dump_map = @load_names = nil
      self
    end
  end
end
