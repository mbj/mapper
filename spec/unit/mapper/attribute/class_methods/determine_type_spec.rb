require 'spec_helper'

describe Mapper::Attribute, '.determine_type' do
  let(:object) { described_class }

  subject { object.determine_type(symbol) }


  context 'with undeterminable type' do
    let(:symbol) { :unkown }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError, 'Unable to determine mapping from :unkown')
    end
  end

  context 'with :embedded_collection' do
    let(:symbol) { :embedded_collection }

    it_should_behave_like 'an idempotent method'

    it { should be(Mapper::Attribute::EmbeddedCollection) }
  end
end
