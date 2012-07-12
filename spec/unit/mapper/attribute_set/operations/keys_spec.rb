require 'spec_helper' 

describe Mapper::AttributeSet::Operations, '#keys' do
  let(:object) { described_class.new(set, operation) }

  let(:set) { Set.new }

  subject { object.keys }


  context 'when loading' do
    let(:operation) { :load }

    context 'and empty' do
      it 'should be empty' do
        should be_empty
      end

      it_should_behave_like 'an idempotent method'
    end

    context 'and key attributes are present' do
      before do
        set << Mapper::Attribute::Object.new(:foo)
        set << Mapper::Attribute::Object.new(:bar, :key => true)
      end

      it 'should return key attribute load names' do
        should == [:bar].to_set
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
        set << Mapper::Attribute::Object.new(:bar, :to => :baz, :key => true)
      end

      it 'should return key attribute load names' do
        should == [:baz].to_set
      end

      it_should_behave_like 'an idempotent method'
    end
  end
end
