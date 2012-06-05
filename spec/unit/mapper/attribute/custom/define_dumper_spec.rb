require 'spec_helper'

describe Mapper::Attribute::Custom,'#define_dumper' do
  let(:object) { described_class.new(:name) }
  let(:dumper_klass) { Class.new.freeze }

  subject { object.define_dumper(dumper_klass) }

  it 'should not modify dumper klass' do
    subject
  end
end
