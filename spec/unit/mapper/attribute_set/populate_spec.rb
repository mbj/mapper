require 'spec_helper'

describe Mapper::AttributeSet, '#populate' do
  subject { object.populate(klass, name) }

  let(:object)    { described_class.new }
  let(:klass)     { mock('Klass')       }
  let(:name)      { :name               }
  let(:new_klass) { mock('New Klass')   }
  let(:attribute) { Mapper::Attribute::Object.new(:id) }

  before do
    attribute.stub(:name)
    object.add(attribute)
    Class.stub(:new => new_klass)
  end

  it 'return new class' do
    should be(new_klass)
  end

  it 'should invoke method on attributes with new klass as param' do
    attribute.should_receive(name).with(new_klass)
    subject
  end
end
