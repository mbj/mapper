require 'spec_helper'

describe Mapper::Attribute::Object, '#load_names' do
  let(:object) { described_class.new(:name) }

  subject { object.load_names }

  it 'should return an array made of load_name' do
    should == [:name]
  end
end
