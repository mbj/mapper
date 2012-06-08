require 'spec_helper'

describe Mapper::Attribute,'.const_name' do
  let(:object) { described_class }
  subject { object.const_name }

  it_should_behave_like 'an idempotent method'

  it 'should return classes const name' do
    should == :Attribute
  end
end
