require 'spec_helper'

describe Mapper::Attribute::Custom,'.new' do
  let(:object) { described_class }

  subject { object.new(name,options) }

  let(:name) { :name }
  let(:options) { {} }

  context 'with defaults' do
    its(:load_names) { should == [name] }
    its(:dump_names) { should == [name] }
  end

  context 'with specifing one name in :to option' do
    let(:options) { { :to => :other } }
    its(:load_names) { should == [name] }
    its(:dump_names) { should == [:other] }
  end

  context 'with specifing multiple names in :to option' do
    let(:options) { { :to => [:foo,:bar] } }
    its(:load_names) { should == [name] }
    its(:dump_names) { should == [:foo,:bar] }
  end
end
