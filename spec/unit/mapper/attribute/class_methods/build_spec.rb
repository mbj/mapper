require 'spec_helper'

describe Mapper::Attribute, '.build' do
  let(:object) { described_class }
  subject { object.build(*arguments) }

  let(:name)    { :name    }

  context 'without options' do
    let(:arguments) { [name] }

    it { should be_instance_of(Mapper::Attribute::Object) }

    its(:load_names) { should == [:name] }
    its(:dump_names) { should == [:name] }
  end

  context 'with options' do
    let(:arguments) { [name, {:type => :custom, :to => :foo}] }

    it { should be_instance_of(Mapper::Attribute::Custom) }

    its(:load_names) { should == [:name] }
    its(:dump_names) { should == [:foo] }
  end
end
