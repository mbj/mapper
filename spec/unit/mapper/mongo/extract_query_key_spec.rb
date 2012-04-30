require 'spec_helper'

require 'mapper/mongo'

describe Mapper::Mapper::Mongo,'#extract_key_from_query' do 
  let(:object) do
    described_class.new(
      :collection => mock,
      :mapper => mapper
    )
  end

  let(:mapper) do
    Mapper::Mapper::Resource.new(
      [
        Mapper::Mapper::Attribute.new(:_id,:key => true),
        Mapper::Mapper::Attribute.new(:firstname)
      ]
    )
  end
  
  subject do
    object.extract_key_from_query(query)
  end

  context 'when query does not contain a key' do
    let(:query) {{ :firstname => 'Susan' }}

    it { should be_nil }
  end

  context 'when query does contain only a key' do
    let(:query) {{ :_id => BSON::ObjectId.new }}
    it { should equal(query) }
  end

  context 'when query does contain more than a key' do
    let(:query) {{ :_id => BSON::ObjectId.new, :firstname => 'Susan' }}
    it { should be_nil }
  end

  context 'with cpk' do
    let(:mapper) do
      Mapper::Mapper::Resource.new(
        [
          Mapper::Mapper::Attribute.new(:a, :key => true),
          Mapper::Mapper::Attribute.new(:b, :key => true),
          Mapper::Mapper::Attribute.new(:c)
        ]
      )
    end

    context 'when query does not contain a key' do
      let(:query) {{ :c => 'Susan' }}

      it { should be_nil }
    end

    context 'when query does only contain a key' do
      let(:query) {{ :a => 'a', :b => 'b' }}

      it { should equal(query) }
    end
  end
end
