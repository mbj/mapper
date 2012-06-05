require 'spec_helper'

describe Mapper::Attribute::Embedded,'#dump' do
  let(:object) { described_class.new(:name,:mapper => mapper) }
  let(:mapper) { mock                                         }
  let(:value)  { mock(:name => mock)                          }

  subject { object.dump(value) }

  it 'should raise not implemented error' do
    expect { subject }.to raise_error(NotImplementedError,"#{described_class.inspect}#coerce_dump must be implemented")
  end
end
