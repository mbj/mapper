require 'spec_helper'

describe Mapper::Attribute::Custom,'#define_dumper' do
  let(:object) { described_class.new(:name) }
  let(:dumper_class) { Class.new.freeze }

  subject { object.define_dumper(dumper_class) }

  it_should_behave_like 'a command method'

  it 'should not modify dumper klass' do
    subject
  end
end
