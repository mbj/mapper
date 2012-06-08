module Mapper
  # A mapped attribute
  class Attribute
    # A mapper for a plain primitive object
    class Object < Attribute
    private
      def initialize(load_name,options={})
        @load_name = load_name
        @dump_name = options.fetch(:to,load_name)
      end

    public

      def loader_method_source
        <<-RUBY
          def #{@load_name}
            load(:#{@dump_name})
          end
        RUBY
      end

      def dumper_method_source
        <<-RUBY
          def #{@dump_name}
            dump(:#{@dump_name})
          end
        RUBY
      end

      def load_names
        [@load_name]
      end

      def dump_names
        [@dump_name]
      end

      def define_loader(klass)
        klass.class_eval(loader_method_source,__FILE__,__LINE__+1)
      end

      def define_dumper(klass)
        klass.class_eval(dumper_method_source,__FILE__,__LINE__+1)
      end

      def dump(object)
        object.send(@load_name)
      end

      def load(dump)
        dump.fetch(@dump_name)
      end
    end
  end
end
