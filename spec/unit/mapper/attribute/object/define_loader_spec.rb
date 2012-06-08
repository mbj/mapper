require 'spec_helper'

describe Mapper::Attribute::Object,'#define_loader' do
  let(:object)  { described_class.new(name,options) }
               
  let(:name)    { :name }
  let(:options) { {} }

  let(:dumper_klass) { mock }

  subject { object.define_loader(dumper_klass) }

  it 'should define method on dumper klass with correct ruby' do
    dumper_klass.
      should_receive(:class_eval).
      with(object.loader_method_source,"/home/mbj/devel/mapper/lib/mapper/attribute/object.rb",33)

    subject
  end
end
