require 'spec_helper'

describe Mapper::Transformer::Dumper,'#dump' do
  let(:domain_object) { DomainObject.new }
  let(:mapper)        { DomainObjectMapper }

  let(:described_class) { mapper::Dumper                     }
  let(:object)          { described_class.new(domain_object) }

  subject { object.dump }

  before do
    object.stub(:mapper => mapper)
  end

  it_should_behave_like 'an idempotent method'

  it 'should return dumped object' do
    should == { :foo => :bar, :id => 1 }
  end
end
