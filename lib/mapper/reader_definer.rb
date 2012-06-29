class Mapper
  # A mixin to define public reader methods.
  # Internally #read(:name) is called.
  module ReaderDefiner
    # Define reader on class
    #
    # @param [Symbol] name
    #   the name of the reader to define
    #
    # @return [self]
    #
    # @api private
    #
    def define_reader(name)
      source = reader_method_source(name)
      class_eval(source,__FILE__,__LINE__)

      self
    end

    private

    # Return source of reader method
    #
    # @api private
    #
    # @return [String]
    #
    def reader_method_source(name)
      # comment to make vim syntax highliter happy
      <<-RUBY
        def #{name}
          read(:#{name})
        end
      RUBY
    end
  end
end
