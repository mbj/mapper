require 'spec_helper'

describe Mapper::Transformer,'#source' do
  let(:object) { described_class.new(source,:operation) }
  let(:source) { mock                                   }

  subject { object.source }

  it 'should return source' do
    should be(source)
  end

  it_should_behave_like 'an idempotent method'
end
