require 'spec_helper'

describe Mapper::ClassMethods,'#load_names' do
  let(:object) do
    Mapper.new do
      map :foo, Object
    end
  end

  subject { object.load_names }

  it 'should return mapper load names' do
    should == [:foo]
  end
end
