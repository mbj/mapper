require 'spec_helper'

describe Mapper::Attribute,'.handles' do
  let(:object) { described_class }

  subject { object.handles }

  before do
    # Yeah not good idea to explictly reset memonization here.
    # Attribute.handles will be removed soon! So this mess will go.
    object.instance_variable_set(:@handles,nil)
  end

  it_should_behave_like 'an idempotent method'

  it 'should return class and const name' do
    should == [object,object.const_name]
  end
end
