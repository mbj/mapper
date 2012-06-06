require 'spec_helper'

describe Mapper,'.new' do
  let(:object) { ::Mapper }
  subject { object.new(&block) }

  let(:block) { nil }

  context 'without block' do
    it 'should not have attributes' do
      subject.attributes.should be_empty
    end
  end

  context 'with block' do
    let(:block) do
      lambda do
        map :foo,Object
      end
    end

    it 'should have attributes' do
      subject.attributes.should_not be_empty
    end
  end
end
