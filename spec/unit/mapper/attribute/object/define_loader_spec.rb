require 'spec_helper'

describe Mapper::Attribute::Object,'#define_loader' do
  let(:object)  { described_class.new(name,options) }
               
  let(:name)    { :name }
  let(:options) { {} }

  let(:dumper_class) { Mapper::Transformer }

  subject { object.define_loader(dumper_class) }

  it 'should define reader method on name' do
    dumper_class.should_receive(:define_reader).with(:name)

    subject
  end

  it_should_behave_like 'a command method'
end
