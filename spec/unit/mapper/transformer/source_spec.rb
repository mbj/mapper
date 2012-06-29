require 'spec_helper'

describe Mapper::Transformer,'#source' do
  let(:object) { described_class.new(mapper,source) }

  let(:mapper)     { mock('Mapper')     }
  let(:source)     { mock('Source')     }

  subject { object.source }

  it 'should return source' do
    should be(source)
  end

  it_should_behave_like 'an idempotent method'
end
