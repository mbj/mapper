require 'spec_helper'

describe Mapper::Registry,'#add_mapper' do
  class FakeMapper
    attr_reader :model
    def initialize(model)
      @model = model
    end
  end

  let(:object) { described_class.new }
  let(:model)  { :some_model }
  let(:mapper) { FakeMapper.new(model) }

  subject { object.add_mapper(mapper) }

  shared_examples_for 'a command method' do
    it 'should return object' do
      subject.should == object
    end
  end

  context 'when adding a new mapper' do
    it_should_behave_like 'a command method'

    it 'should add the mapper' do
      subject
      object.mapper(model).should == mapper
    end
  end

  context 'when mapper was already present' do
    before do
      object.add_mapper(FakeMapper.new(:some_other_model))
    end

    it_should_behave_like 'a command method'

    it 'should override mapper' do
      subject
      object.mapper(model).should == mapper
    end
  end
end
