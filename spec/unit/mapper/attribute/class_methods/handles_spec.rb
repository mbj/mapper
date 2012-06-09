require 'spec_helper'

describe Mapper::Attribute,'.handles' do
  let(:object) { described_class }

  subject { object.handles }

  it_should_behave_like 'an idempotent method'

  it 'should return class and const name' do
    should == [object,object.const_name]
  end
end
