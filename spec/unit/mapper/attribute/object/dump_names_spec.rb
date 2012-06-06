require 'spec_helper'

describe Mapper::Attribute::Object,'#dump_names' do
  let(:object) { described_class.new(:name) }

  subject { object.dump_names }

  it 'should return an array made of dump_name' do
    should == [:name]
  end
end
