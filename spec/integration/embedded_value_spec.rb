require 'spec_helper'

require 'mapper/virtus'

describe 'embedded value' do

  let(:person_mapper) do
    Mapper::Mapper::Resource.new(
      [
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname)
      ]
    )
  end

  let(:family_mapper) do
    Mapper::Mapper::Resource.new(
      [
        Mapper::Mapper::EmbeddedValue.new(:father,:mapper => person_mapper),
        Mapper::Mapper::EmbeddedValue.new(:mother,:mapper => person_mapper),
        Mapper::Mapper::EmbeddedValue.new(:child, :mapper => person_mapper),
      ]
    )
  end

  let(:family) do
    {
      :father => { :firstname => 'Bob',  :lastname => 'Doe' },
      :mother => { :firstname => 'Alice',:lastname => 'Doe' },
      :child =>  { :firstname => 'Ben',  :lastname => 'Doe' }
    }
  end

  let(:dump) do
    {
      :father_firstname => 'Bob',
      :father_lastname  => 'Doe',
      :mother_firstname => 'Alice',
      :mother_lastname  => 'Doe',
      :child_firstname   => 'Ben',
      :child_lastname   => 'Doe',
    }
  end

  specify 'allows to dump' do
    family_mapper.dump(family).should == dump
  end

  specify 'allows to load from dump' do
    family_mapper.load(dump).should == family
  end

  specify 'allows to round trip' do
    family_mapper.load(family_mapper.dump(family)).should == family
  end
end
