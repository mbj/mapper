require 'spec_helper'

describe Mapper::AttributeSet::Operations, '#execute' do
  let(:object)    { described_class.new(set, operation) }

  let(:set)       { Set.new }
  let(:name)      { :foo }
  let(:result)    { mock }
  let(:attribute) { Mapper::Attribute::Object.new(:load_name, :to => :dump_name) }

  subject { object.execute(name, value) }

  context 'when loading' do
    let(:operation) { :load }
    let(:value)     { mock(:dump_name => result) }
    let(:name)      { :load_name }

    context 'and attribute with name does not exist' do
      it 'should raise error' do
        expect { subject }.to raise_error(IndexError)
      end
    end

    context 'and attributes does exist' do
      before do
        set << attribute
      end

      it 'should return result' do
        should be(result)
      end

      it_should_behave_like 'an idempotent method'
    end
  end

  context 'when loading' do
    let(:operation) { :dump }
    let(:value)     { mock(:load_name => result) }
    let(:name)      { :dump_name }

    context 'and attribute with name does not exist' do
      it 'should raise error' do
        expect { subject }.to raise_error(IndexError)
      end
    end

    context 'and attributes does exist' do
      before do
        set << attribute
      end

      it 'should return result' do
        should be(result)
      end

      it_should_behave_like 'an idempotent method'
    end
  end
end
