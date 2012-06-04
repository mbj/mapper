module Mapper
  # mapped attribute base class
  class Attribute
    extend ::Virtus::DescendantsTracker

    def self.build(name,class_or_name,options={})
      type = determine_type(class_or_name)
      type.new(name,options)
    end

    def self.determine_type(class_or_name)
      type = descendants.detect do |descendant| 
        descendant.handle?(class_or_name) 
      end

      unless type
        raise "cannot determine type from: #{class_or_name.inspect}"
      end

      type
    end

    def self.symbol_name
      name.split('::').last.to_sym
    end

    def self.handle?(class_or_name)
      [self,symbol_name].include?(class_or_name)
    end
  end
end
