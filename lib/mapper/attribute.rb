module Mapper
  # mapped attribute base class
  class Attribute
    extend ::Virtus::DescendantsTracker

    def self.build(name,class_or_name,options={})
      type = determine_type(class_or_name)
      type.new(name,options)
    end

    def self.determine_type(class_or_name)
      # This test needs to be removed by a primitive lookup like in Virtus
      # As there is currently no support for specialized primitives it is not done.
      if class_or_name == ::Object
        return Attribute::Object
      end

      type = descendants.detect do |descendant| 
        descendant.handle?(class_or_name) 
      end

      unless type
        raise ArgumentError,"Unable to determine mapping from: #{class_or_name.inspect}"
      end

      type
    end

    def self.const_name
      name.split('::').last.to_sym
    end

    def self.handle?(class_or_name)
      handles.include?(class_or_name)
    end

    def self.handles
      [self,const_name]
    end
  end
end
