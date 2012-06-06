module Mapper
  # A mapped attribute
  class Attribute
    # A mapper attribute with custom behaviour
    class Custom < Object
      attr_reader :dump_names

      def define_loader(klass)
        self
      end

      def define_dumper(klass)
        self
      end

    private

      def initialize(name,options={})
        @load_name = name 
        @dump_names = Array(options.fetch(:to,name))
      end
    end
  end
end
