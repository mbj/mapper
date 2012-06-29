require 'spec_helper'

describe Mapper, '#model' do
  subject { object.model }

  let(:object) { described_class.new(model,mock) }
  let(:model)  { mock('Model') }

  it { should be(model) }

  it_should_behave_like 'an idempotent method'
end
