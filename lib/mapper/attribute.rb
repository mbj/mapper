module Mapper
  # A mapped attribute
  class Attribute
    extend ::Virtus::DescendantsTracker

    def define_dumper(klass)
      klass.class_eval(dumper_method_source,__FILE__,__LINE__)

      self
    end

    def coerce_load(value); value; end
    def coerce_dump(value); value; end

    def self.build(name,class_or_name,options={})
      type = determine_type(class_or_name)
      type.new(name,options)
    end

    def self.determine_type(class_or_name)
      type = descendants.detect { |descendant| descendant.handle?(class_or_name) }

      unless type
        raise "cannot determine type from: #{class_or_name.inspect}"
      end

      type
    end

    def self.symbol_name
      name.split('::').last.to_sym
    end

    def self.handle?(class_or_name)
      handle_symbol_name?(class_or_name) or handle_primitive?(class_or_name)
    end

    def self.handle_symbol_name?(class_or_name)
      [self,symbol_name].include?(class_or_name)
    end

    def self.handle_primitive?(class_or_name)
      primitive == class_or_name
    end

    class Object < Attribute
      def self.primitive(primitive = Undefined)
        if primitive == Undefined
          @primitive || raise
        else
          @primitive = primitive
        end
      end

      primitive ::Object

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
        if @load_block
          klass.send(:define_method,@load_name,&@load_block)
        else
          klass.class_eval(loader_method_source,__FILE__,__LINE__)
        end

        self
      end

      def dump_value(instance)
        instance.send(@load_name)
      end

      def load_value(dump)
        dump.fetch(@dump_name)
      end

      def dump(instance)
        coerce_dump(dump_value(instance))
      end

      def load(dump)
        coerce_load(load_value(dump))
      end

      def loader_method_source
        <<-RUBY
          def #{@load_name}
            __load__(:#{@dump_name})
          end
        RUBY
      end

      def dumper_method_source
        <<-RUBY
          def #{@dump_name}
            __dump__(:#{@dump_name})
          end
        RUBY
      end
    end

    class Custom < Object
      def self.primitive; nil; end

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

    class EmbeddedDocument < Object
      primitive Object

      def initialize(name,options)
        @mapper = options.fetch(:mapper)
        super
      end

      def coerce_load(value)
        if value
          @mapper.load(value)
        end
      end

      def coerce_dump(value)
        if value
          @mapper.dump(value)
        end
      end
    end

    # An attribute mapped to embedded collection
    class EmbeddedCollection < Object
      primitive Object

      def initialize(name,options)
        @mapper = options.fetch(:mapper)
        super
      end

      def coerce_load(value)
        value.map do |item|
          @mapper.load(item) 
        end
      end

      def coerce_dump(value)
        value.map do |item|
          @mapper.dump(item)
        end
      end
    end
  end
end
