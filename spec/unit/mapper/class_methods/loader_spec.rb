require 'spec_helper'

describe Mapper::ClassMethods,'#loader' do
  let(:described_class) do
    ::Mapper.new do
      map :foo, Object
    end
  end

  let(:object) { described_class }

  let(:dump)   { { :foo => :bar } }

  subject { object.loader(dump) }

  its(:class) { should == described_class::Loader }
  its(:dump)  { should == dump }
end
