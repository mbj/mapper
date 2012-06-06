require 'spec_helper'

describe Mapper::Transformer,'#mapper' do
  let(:described_class) do
    Class.new(Mapper::Transformer).tap do |klass|
      klass.stub(:mapper => mapper)
    end
  end

  let(:mapper) { mock }

  let(:object) { described_class.new }

  subject { object.mapper }

  it 'should return class mapper' do
    should be(mapper)
  end
end
