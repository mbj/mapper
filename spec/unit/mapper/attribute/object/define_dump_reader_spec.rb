require 'spec_helper'

describe Mapper::Attribute::Object, '#define_dump_reader' do
  let(:object)  { described_class.new(name, options) }

  let(:name)    { :name }
  let(:options) { {} }

  let(:dumper_class) { mock }

  subject { object.define_dump_reader(dumper_class) }

  context 'when dump name is NOT changed' do

    before do
      dumper_class.should_receive(:define_reader).with(:name)
    end

    it 'should define method on dump name' do

      subject
    end

    it_should_behave_like 'a command method'
  end

  context 'when dump name is changed' do
    let(:options) { { :to => :other } }

    before do
      dumper_class.should_receive(:define_reader).with(:other)
    end

    it 'should define method on dump name' do

      subject
    end

    it_should_behave_like 'a command method'
  end
end
