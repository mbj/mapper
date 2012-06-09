require 'spec_helper'

describe Mapper::AttributeSet,'#load_operations' do
  let(:object) { described_class.new }

  let(:operation) { subject.instance_variable_get(:@operation) }

  subject { object.load_operations }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Mapper::AttributeSet::Operations) }

  specify { operation.should == :load }
end
