class Mapper
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
        klass.define_reader(@load_name)

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
        klass.define_reader(@dump_name)

        self
      end

      # Define reader method on dump wrapper class
      #
      # @param [Class] klass
      #
      # @return [self]
      #
      # @api private
      #
      def define_dump_reader(klass)
        dump_names.each do |name|
          klass.define_reader(name)
        end

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
        dump.send(@dump_name)
      end
    end
  end
end
