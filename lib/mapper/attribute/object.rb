module Mapper
  # A mapped attribute
  class Attribute
    # A mapper for a plain primitive object
    class Object < Attribute
      def self.handle?(class_or_name)
        # @dkubb yeah with will be fixed.
        if self == ::Mapper::Attribute::Object
          class_or_name == ::Object
        end || super
      end

      def add_to_dump_map(dump_map)
        dump_map[@dump_name]=self
      end

      def add_to_load_map(load_map)
        load_map[@load_name]=self
      end

      def initialize(load_name,options)
        @load_name = load_name
        @dump_name = options.fetch(:to,load_name)
      end

      def define_loader(klass)
        klass.class_eval(loader_method_source,__FILE__,__LINE__)
      end

      def loader_method_source
        <<-RUBY
          def #{@load_name}
            __load__(:#{@dump_name})
          end
        RUBY
      end

      def define_dumper(klass)
        klass.class_eval(dumper_method_source,__FILE__,__LINE__+1)
      end

      def dumper_method_source
        <<-RUBY
          def #{@dump_name}
            __dump__(:#{@dump_name})
          end
        RUBY
      end

      def dump_value(object)
        object.send(@load_name)
      end

      def load_value(dump)
        dump.fetch(@dump_name)
      end

      def dump(instance)
        dump_value(instance)
      end

      def load(dump)
        load_value(dump)
      end
    end
  end
end
