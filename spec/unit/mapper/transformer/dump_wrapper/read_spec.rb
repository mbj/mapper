require 'spec_helper'

describe Mapper::Transformer::DumpWrapper,'#read' do
  let(:object) { described_class.new(data) }
  subject { object.send(:read,name) }

  let(:data) { { :foo => :bar } }

  context 'when name does exist' do
    let(:name) { :foo }
    
    it 'should return value' do
      should == :bar
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'when name does NOT exist' do
    let(:name) { :unexistend }
    
    it 'should raise error' do
      expect { subject }.to raise_error(IndexError)
    end
  end
end
