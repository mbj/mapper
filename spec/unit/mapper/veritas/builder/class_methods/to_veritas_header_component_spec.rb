require 'spec_helper'

describe Mapper::Veritas::Builder,'.to_veritas_header_component' do

  subject { object.to_veritas_header_component(attribute) }

  let(:object) { described_class }
  
  context 'with attribute that maps to single dump_name' do
    let(:attribute) { mock('Attribute', :dump_names => [:foo]) }

    it { should == [[:foo, ::Object] ] }
  end

  context 'with attribute that maps to single dump_name' do
    let(:attribute) { mock('Attribute', :dump_names => [:foo,:bar]) }

    it { should == [[:foo, ::Object], [:bar, ::Object] ] }
  end
end
