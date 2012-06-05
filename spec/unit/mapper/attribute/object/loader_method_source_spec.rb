require 'spec_helper'

describe Mapper::Attribute::Object,'#loader_method_source' do
  let(:object)  { described_class.new(name,options) }
               
  let(:name)    { :name }
  let(:options) { {} }

  subject { object.loader_method_source }

  context 'with defaults' do
    it 'should create correct ruby' do
      compress_prefix(subject).should == compress_prefix(<<-RUBY)
        def name
          load(:name)
        end
      RUBY
    end
  end

  context 'with aliased dump name' do
    let(:options) { { :to => :other } }
    it 'should create correct ruby' do
      compress_prefix(subject).should == compress_prefix(<<-RUBY)
        def name
          load(:other)
        end
      RUBY
    end
  end
end
