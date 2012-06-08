require 'spec_helper'

describe Mapper::Transformer,'#mapper' do
  let(:described_class) do
    Class.new(Mapper::Transformer).tap do |klass|
      klass.stub(:mapper => mapper)
    end
  end

  let(:source)    { mock }
  let(:operation) { mock }
  let(:mapper)    { mock }

  let(:object) { described_class.new(source,operation) }

  subject { object.mapper }

  it 'should return class mapper' do
    should be(mapper)
  end

  it_should_behave_like 'an idempotent method'
end
