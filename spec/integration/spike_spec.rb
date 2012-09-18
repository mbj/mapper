require 'spec_helper'

describe 'spike spec' do
  class Phone
    include Virtus::ValueObject

    attribute :number, String
    attribute :type,   String

    Mapper = ::Mapper::Document.build(self) do
      map :number
      map :type
    end

  end

  class Address
    include Virtus::ValueObject

    attribute :lines,    String
    attribute :postcode, String

    Mapper = ::Mapper::Document.build(self) do
      map :lines
      map :postcode
    end
  end

  class User
    include Virtus::ValueObject

    attribute :firstname,       String
    attribute :lastname,        String
    attribute :address,         Address
    attribute :phones,          Array[Phone]
    attribute :preferred_phone, Phone
    attribute :vat_rate,        Rational

    Mapper = ::Mapper::Document.build(self) do
      map :firstname,       :to => :surname
      map :lastname
      map :address,         :type => :embedded_document,   :mapper => Address::Mapper
      map :phones,          :type => :embedded_collection, :mapper => Phone::Mapper
      map :vat_rate,        :type => :custom, :to => [:vat_rate_numerator, :vat_rate_denominator, :vat_rate]
      map :preferred_phone, :type => :custom, :to => :preferred_phone_idx

      dumper do
        def preferred_phone_idx
          source.phones.index(source.preferred_phone)
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

      private

        def with_vat_rate
          vat_rate = source.vat_rate
          yield vat_rate if vat_rate
        end
      end

      loader do
        def vat_rate
          Rational(source.vat_rate_numerator, source.vat_rate_denominator)
        end

        def preferred_phone
          prefered_phone_idx = source.preferred_phone_idx
          if prefered_phone_idx
            phones.fetch(prefered_phone_idx)
          end
        end
      end
    end
  end

  it 'should work' do
    phone_a = Phone.new(:type => :home, :number => '0815 - 1')
    phone_b = Phone.new(:type => :mobile, :number => '0815 - 2')

    address = Address.new(
      :lines => "Snake Oil Ink\nPostbox foo bar",
      :postcode => "085123"
    )

    user = User.new(
      :firstname => 'John',
      :lastname => 'Doe',
      :address => address,
      :phones => [phone_a, phone_b],
      :preferred_phone => phone_b,
      :vat_rate => Rational(21, 100)
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
