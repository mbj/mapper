require 'spec_helper'

describe Mapper::Attribute::Embedded,'#load' do
  let(:object) { described_class.new(:name,:mapper => mapper) }
  let(:mapper) { mock                                         }
  let(:value)  { { :name => mock }                            }

  subject { object.load(value) }

  it 'should raise not implemented error' do
    expect { subject }.to raise_error(NotImplementedError,"#{described_class.inspect}#coerce_load must be implemented")
  end
end
