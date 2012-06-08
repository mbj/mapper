require 'spec_helper'

describe Mapper::Attribute::Custom,'#define_loader' do
  let(:object) { described_class.new(:name) }
  let(:loader_class) { Class.new.freeze }

  subject { object.define_loader(loader_class) }

  it_should_behave_like 'a command method'

  it 'should not modify loader klass' do
    subject
  end
end
