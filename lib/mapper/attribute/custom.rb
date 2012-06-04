module Mapper
  # A mapped attribute
  class Attribute
    # A mapper attribute with custom behaviour
    class Custom < Object
      def initialize(name,options)
        @load_name = name 
        @dump_names = Array(options.fetch(:to,name))
      end

      def add_to_dump_map(dump_map)
        @dump_names.each do |name|
          dump_map[name]=self
        end
      end

      def define_loader(klass)
      end

      def define_dumper(klass)
      end
    end
  end
end
