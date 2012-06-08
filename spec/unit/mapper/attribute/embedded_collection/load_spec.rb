require 'spec_helper'

describe Mapper::Attribute::EmbeddedCollection,'#load' do
  let(:object)  { described_class.new(:name,:mapper => mapper) }
  let(:mapper)  { Mapper::Attribute::Object.new(:other_name)   }
  let(:item)    { mock }
  let(:coerced) { mock }
  let(:value)   { [item] }
  let(:dump)    { { :name => value } }

  subject { object.load(dump) }

  it 'should delegate each value to inner mapper' do
    mapper.should_receive(:load).with(item).and_return(coerced)
    subject.should == [coerced]
  end
end
