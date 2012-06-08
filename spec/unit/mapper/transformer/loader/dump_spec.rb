require 'spec_helper'

describe Mapper::Transformer::Loader,'#dump' do
  let(:object) { described_class.new(dump) }
  let(:dump)   { mock }

  subject { object.dump }

  it 'should return wrapped dump' do
    should be(dump)
  end
end
