require 'spec_helper' 

describe Mapper::AttributeSet::Operations,'#names' do
  let(:object) { described_class.new(set,operation) }

  let(:set) { Set.new }

  subject { object.names }


  context 'when loading' do
    let(:operation) { :load }

    context 'and empty' do
      it 'should be empty' do
        should be_empty
      end

      it_should_behave_like 'an idempotent method'
    end

    context 'and attributes are present' do
      before do
        set << Mapper::Attribute::Object.new(:foo)
        set << Mapper::Attribute::Object.new(:bar)
      end

      it 'should return attribute load names' do
        should == [:foo,:bar].to_set
      end

      it_should_behave_like 'an idempotent method'
    end
  end

  context 'when dumping' do
    let(:operation) { :dump }

    context 'and empty' do
      it 'should be empty' do
        should be_empty
      end

      it_should_behave_like 'an idempotent method'
    end

    context 'and attributes are present' do
      before do
        set << Mapper::Attribute::Object.new(:foo)
        set << Mapper::Attribute::Object.new(:bar,:to => :baz)
      end

      it 'should return attribute load names' do
        should == [:foo,:baz].to_set
      end

      it_should_behave_like 'an idempotent method'
    end
  end
end
