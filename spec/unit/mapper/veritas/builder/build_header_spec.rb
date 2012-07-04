require 'spec_helper'

describe Mapper::Veritas::Builder,'#build_header' do

  subject { object.build_header }

  let(:object) { described_class.new(model,mapper_class) }

  let(:mapper_class) { mock('Mapper Class') }
  let(:model)        { mock('Model') }

  before do
    object.map(:foo)
    object.map(:bar)
  end

  it 'should build a simple relation header' do
    should == [[:foo,Object],[:bar,Object]]
  end
end
