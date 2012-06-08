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

      # Define reader on transformer
      #
      # @param [Class] klass 
      #   the loader or dumper class to define the reader on
      #
      # @param [String] source
      #   the source of the method to define
      #
      # @api private
      #
      # @return [self]
      #
      def define_reader(klass,source)
        klass.class_eval(source,__FILE__,__LINE__+1)

        self
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

      # Return loader method source
      #
      # @return [String]
      #
      # @api private
      #
      def loader_method_source
        Transformer.reader_method_source(@load_name)
      end

      # Return dumper method source
      #
      # @return [String]
      #
      # @api private
      def dumper_method_source
        Transformer.reader_method_source(@dump_name)
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
        define_reader(klass,loader_method_source)

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
        define_reader(klass,dumper_method_source)

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
      # TODO: Introduce dump accessor object.
      def load(dump)
        dump.fetch(@dump_name)
      end
    end
  end
end
