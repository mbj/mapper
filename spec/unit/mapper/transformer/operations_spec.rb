require 'spec_helper'

describe Mapper::Transformer,'#operations' do

  subject { object.send(:operations) }

  let(:object) { described_class.new(mock,mock) }

  it 'should raise error' do
    expect { subject }.to raise_error(NotImplementedError,'Mapper::Transformer#operations must be implemented')
  end
end
