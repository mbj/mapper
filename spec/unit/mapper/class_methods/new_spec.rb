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

  context 'with block defining attributes' do
    let(:block) do
      proc do 
        map :foo,Object
      end
    end

    it 'should have attributes' do
      subject.attributes.should_not be_empty
    end
  end
end
