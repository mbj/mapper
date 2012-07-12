require 'spec_helper'

describe Mapper::Attribute::EmbeddedCollection, '#dump' do
  let(:object)        { described_class.new(:name, :mapper => mapper) }
  let(:mapper)        { Mapper::Attribute::Object.new(:other_name)   }
  let(:domain_object) { mock(:name => value)                         }
  let(:item)          { mock                                         }
  let(:coerced)       { mock                                         }

  subject { object.dump(domain_object) }

  let(:value) { [item] }

  it 'should delegate each value to inner mapper' do
    mapper.should_receive(:dump).with(item).and_return(coerced)
    subject.should == [coerced]
  end
end
