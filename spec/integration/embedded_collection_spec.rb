require 'spec_helper'

describe 'embedded collection' do

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
        Mapper::Mapper::EmbeddedDocument.new(:father,:mapper => person_mapper),
        Mapper::Mapper::EmbeddedDocument.new(:mother,:mapper => person_mapper),
        Mapper::Mapper::EmbeddedCollection.new(
          :children, 
          :mapper => person_mapper
        ),
      ]
    )
  end

  let(:family) do
    {
      :father => { :firstname => 'Bob',  :lastname => 'Doe' },
      :mother => { :firstname => 'Alice',:lastname => 'Doe' },
      :children => [
        { :firstname => 'Ben',  :lastname => 'Doe' },
        { :firstname => 'Liz',  :lastname => 'Doe' }
      ]
    }
  end

  let(:dump) do
    {
      :father => { :firstname => 'Bob',  :lastname => 'Doe' },
      :mother => { :firstname => 'Alice',:lastname => 'Doe' },
      :children => [
        { :firstname => 'Ben',  :lastname => 'Doe' },
        { :firstname => 'Liz',  :lastname => 'Doe' }
      ]
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

  specify 'allows to rename attributes' do
    mapper = Mapper::Mapper::Resource.new(
      [
        Mapper::Mapper::EmbeddedDocument.new(:father, :mapper => person_mapper),
        Mapper::Mapper::EmbeddedDocument.new(:mother, :mapper => person_mapper),
        Mapper::Mapper::EmbeddedCollection.new(
          :children, 
          :mapper => person_mapper,
          :as => :kids
        )
      ]
    )

    dump = {
      :father => { :firstname => 'Bob',  :lastname => 'Doe' },
      :mother => { :firstname => 'Alice',:lastname => 'Doe' },
      :kids => [
        { :firstname => 'Ben',  :lastname => 'Doe' },
        { :firstname => 'Liz',  :lastname => 'Doe' }
      ]
    }

    mapper.load(dump).should == family
    mapper.dump(family).should == dump
  end
end
