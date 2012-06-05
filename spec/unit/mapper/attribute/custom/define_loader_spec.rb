require 'spec_helper'

describe Mapper::Attribute::Custom,'#define_loader' do
  let(:object) { described_class.new(:name) }
  let(:loader_klass) { Class.new.freeze }

  subject { object.define_loader(loader_klass) }

  it 'should not modify loader klass' do
    subject
  end
end
