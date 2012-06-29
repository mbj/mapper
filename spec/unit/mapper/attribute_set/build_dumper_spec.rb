require 'spec_helper'

describe Mapper::AttributeSet,'#build_dumper' do
  subject { object.build_dumper }

  let(:object)       { described_class.new }
  let(:dumper_class) { mock('Class') }

  before do
    object.stub(:populate => dumper_class)
  end

  it 'should call #populate' do
    object.should_receive(:populate).with(Mapper::Transformer::Dumper,:define_dumper).and_return(dumper_class)
    subject
  end

  it { should be(dumper_class) }
end
