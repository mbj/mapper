require 'spec_helper'

describe Mapper::Attribute,'.handle?' do
  # As .handle is defined on attribute but supposed to be called on subclasses of 
  # attribute I'm not using veritas style unit specs here.
  #
  it 'should return true when attribute subclass can handle class or name' do
    Mapper::Attribute::Object.handle?(:Object).should be_true
  end

  it 'should return false when attribute subclass can handle class or name' do
    Mapper::Attribute::Object.handle?(:EmbeddedValue).should be_false
  end

  it 'should return false when called on attribute' do
    described_class.handle?(:Object).should be_false
  end
end
