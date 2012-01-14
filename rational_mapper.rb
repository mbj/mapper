module Mapper
  # Mongo specific Mapper for rationals.
  class RationalMapper < ::Mapper::AttributeMapper
    def initialize(name,options={})
      super(name,options)
    end

    def load(object)
      self.class.load(super(object))
    end

    def dump(object)
      self.class.dump(super(object))
    end

    def self.load(value)
      case value
      when Hash
        numerator = value.fetch('numerator') do
          raise ArgumentError,"missing 'numerator' in options"
        end
        denominator = value.fetch('denominator') do
          raise ArgumentError,"missing 'denominator' in options"
        end
        Rational(numerator,denominator)
      when NilClass
        nil
      else
        raise
      end
    end

    def self.dump(value)
      case value
      when Rational
        { 
          :numerator => value.numerator, 
          :denominator => value.denominator,
          :value => value.to_f
        }
      when NilClass
        nil
      else
        raise "cannot: #{value.inspect} with RationalMapper"
      end
    end
  end
end
