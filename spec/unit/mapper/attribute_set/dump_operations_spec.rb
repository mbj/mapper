require 'spec_helper'

describe Mapper::AttributeSet, '#dump_operations' do
  subject { object.dump_operations }

  let(:object)       { described_class.new                        }
  let(:operation)    { subject.instance_variable_get(:@operation) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Mapper::AttributeSet::Operations) }

  specify { operation.should == :dump }
end
