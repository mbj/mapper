require 'spec_helper'

describe Mapper::Registry,'#mapper' do
  let(:object) { described_class.new }
  class FakeMapper
    attr_reader :modl
    def initialize(model)
      @model = model
    end
  end

  subject { object.mapper(model) }

  context 'when requesting a registred model' do
    let(:model) { :some_model }
    let(:mapper) { FakeMapper.new(model) }

    before do
      object.add_mapper(mapper)
    end

    it 'should return mapper' do
      subject.should == mapper
    end
  end

  context 'when requesting an unregistred model' do
    let(:model) { :some_model }

    it 'should raise an ArgumentException' do
      expect do 
        subject 
      end.to raise_error(ArgumentError,'missing mapper for :some_model')
    end
  end
end
