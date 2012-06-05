require 'spec_helper'

describe 'spike spec' do
  class Phone
    include Virtus::ValueObject

    attribute :number,String
    attribute :type,String

    class Mapper
      include ::Mapper
      model Phone
      map :number, Object
      map :type,   Object
    end

    class LoaderByHand
      def initialize(dump)
        @dump = dump
      end

      def number
        @dump.fetch(:number)
      end

      def type
        @dump.fetch(:type)
      end

      def load
        Phone.new(
          :number => number,
          :type => type
        )
      end
    end

    class DumperByHand
      def initialize(phone)
        @phone = phone
      end

      def phone
        @phone.number
      end

      def type
        @phone.type
      end

      def dump
        {
          :number => number,
          :type => type
        }
      end
    end
  end

  class Address
    include Virtus::ValueObject

    attribute :lines,String
    attribute :postcode,String

    class Mapper
      include ::Mapper
      model Address
      map :lines,    Object
      map :postcode, Object
    end
  end

  class User
    include Virtus::ValueObject

    attribute :firstname,String
    attribute :lastname,String
    attribute :address,Address
    attribute :phones,Array[Phone]
    attribute :preferred_phone,Phone
    attribute :vat_rate,Rational

    class Mapper 
      include ::Mapper
      model ::User

      map :firstname,       Object,             :to => :surname
      map :lastname,        Object
      map :address,         EmbeddedDocument,   :mapper => Address::Mapper
      map :phones,          EmbeddedCollection, :mapper => Phone::Mapper
      map :vat_rate,        Custom,             :to => [:vat_rate_numerator,:vat_rate_denominator,:vat_rate]
      map :preferred_phone, Custom,             :to => :preferred_phone_idx

      class Dumper
        def preferred_phone_idx
          object.phones.index(object.preferred_phone)
        end

        def vat_rate_numerator
          with_vat_rate(&:numerator)
        end
        
        def vat_rate_denominator
          with_vat_rate(&:denominator)
        end

        def vat_rate
          with_vat_rate(&:to_f)
        end

        def with_vat_rate
          vat_rate = object.vat_rate
          yield vat_rate if vat_rate
        end
      end

      class Loader
        def vat_rate
          Rational(@dump[:vat_rate_numerator],@dump[:vat_rate_denominator])
        end

        def preferred_phone
          prefered_phone_idx = @dump[:preferred_phone_idx]
          if prefered_phone_idx
            phones.fetch(prefered_phone_idx)
          end
        end
      end
    end
  end

  it 'should work' do
    phone_a = Phone.new(:type => :home, :number => '0815 - 1')
    phone_b = Phone.new(:type => :mobile,:number => '0815 - 2')

    address = Address.new(
      :lines => "Snake Oil Ink\nPostbox foo bar",
      :postcode => "085123"
    )

    user = User.new(
      :firstname => 'John',
      :lastname => 'Doe',
      :address => address,
      :phones => [phone_a,phone_b],
      :preferred_phone => phone_b,
      :vat_rate => Rational(21,100)
    )

    dump = User::Mapper.dump(user)

    dump.should == { 
      :surname  =>'John',
      :lastname =>'Doe',
      :address  =>{:lines=>"Snake Oil Ink\nPostbox foo bar", :postcode=>'085123'},
      :phones   =>
        [
          {:number=>"0815 - 1", :type=>"home"},
          {:number=>"0815 - 2", :type=>"mobile"}
        ],
      :vat_rate_numerator => 21,
      :vat_rate_denominator => 100,
      :vat_rate => 0.21,
      :preferred_phone_idx=>1
    }

    loaded = User::Mapper.load(dump)
    loaded.should == user
  end
end
