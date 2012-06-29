require 'spec_helper'

describe Mapper::AttributeSet,'#build_loader' do
  subject { object.build_loader }

  let(:object)       { described_class.new }
  let(:loader_class) { mock('Class') }

  before do
    object.stub(:populate => loader_class)
  end

  it 'should call #populate' do
    object.should_receive(:populate).with(Mapper::Transformer::Loader,:define_loader).and_return(loader_class)
    subject
  end

  it { should be(loader_class) }
end
