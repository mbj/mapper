require 'spec_helper'

describe Mapper::Attribute::Object, '#define_dumper' do
  let(:object)  { described_class.new(name, options) }

  let(:name)    { :name }
  let(:options) { {} }

  let(:dumper_class) { Mapper::Transformer }


  subject { object.define_dumper(dumper_class) }

  context 'when dump name is NOT changed' do
    it 'should define method on dump name' do
      dumper_class.should_receive(:define_reader).with(:name)

      subject
    end

    it_should_behave_like 'a command method'
  end

  context 'when dump name is changed' do
    let(:options) { { :to => :other } }

    it 'should define method on dump name' do
      dumper_class.should_receive(:define_reader).with(:other)

      subject
    end

    it_should_behave_like 'a command method'
  end
end
