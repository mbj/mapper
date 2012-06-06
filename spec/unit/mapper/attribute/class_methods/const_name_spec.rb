require 'spec_helper'

describe Mapper::Attribute,'.const_name' do
  let(:object) { described_class }
  subject { object.const_name }
  it 'should return classes const name' do
    should == :Attribute
  end
end
