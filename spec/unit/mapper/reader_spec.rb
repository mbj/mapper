require 'spec_helper'

describe Mapper,'#reader' do

  subject { object.reader }

  let(:object) { described_class.new(mock,mock) }

  it 'should raise error' do
    expect { subject }.to raise_error(NotImplementedError,'Mapper#reader must be implemented')
  end
end
