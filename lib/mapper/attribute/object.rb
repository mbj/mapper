module Mapper
  # A mapped attribute
  class Attribute
    # A mapper for a plain primitive object
    class Object < Attribute
      private
      # Initialize attribute
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(load_name,options={})
        @load_name = load_name
        @dump_name = options.fetch(:to,load_name)
        @key       = !!options.fetch(:key,false)
      end

      public

      # Return wheather this attribute is a key
      #
      # @return [true|false]
      #
      # @api private
      # 
      def key?
        @key
      end

      # Return source of method to be defined on loader
      #
      # @return [String]
      #
      # @api private
      #
      def loader_method_source
        <<-RUBY
          def #{@load_name}
            load(:#{@dump_name})
          end
        RUBY
      end

      # Return source of method to be defined on dumper
      #
      # @return [String]
      #
      # @api private
      #
      def dumper_method_source
        <<-RUBY
          def #{@dump_name}
            dump(:#{@dump_name})
          end
        RUBY
      end

      # Return names of domain object attributes this attribute loads
      #
      # @return [Array<Symbol>]
      #
      # @api private
      #
      def load_names
        [@load_name]
      end

      # Return names of fields this attribute creates in dump
      #
      # @return [Array<Symbol>]
      #
      # @api private
      #
      def dump_names
        [@dump_name]
      end

      # Define loader method on class
      #
      # @param [Class] klass
      #
      # @return [self]
      #
      # @api private
      #
      def define_loader(klass)
        klass.class_eval(loader_method_source,__FILE__,__LINE__+1)

        self
      end

      # Define dumper method on class
      #
      # @param [Class] klass
      #
      # @return [self]
      #
      # @api private
      #
      def define_dumper(klass)
        klass.class_eval(dumper_method_source,__FILE__,__LINE__+1)

        self
      end

      # Transform attribute of domain object into dumped representation
      #
      # @param [Object] object
      #
      # @return [Object]
      #
      # @api private
      #
      def dump(object)
        object.send(@load_name)
      end

      # Transform dumped fields to domain object attribute
      #
      # @param [Object] dump
      #
      # @return [Object]
      #
      # @api private
      #
      def load(dump)
        dump.fetch(@dump_name)
      end
    end
  end
end
