require 'spec_helper'

describe Mapper::Veritas::DumpWrapper, '#read' do
  subject { object.send(:read, name) }

  let(:object) { described_class.new(tuple) }

  let(:header) { Veritas::Relation::Header.new([[:foo, Integer]]) }
  let(:tuple)  { Veritas::Tuple.new(header, data)                 }
  let(:data)   { [ 1 ]                                           }


  context 'when name does exist' do
    let(:name) { :foo }

    it 'should return value' do
      should be(1)
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
