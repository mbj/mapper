require 'spec_helper'

describe Mapper, '.new' do
  subject { object.new(model, attributes) }

  let(:object)     { described_class }

  let(:model)      { mock('Model') }
  let(:attributes) { mock('Attributes') }

  it { should be_frozen }
end
