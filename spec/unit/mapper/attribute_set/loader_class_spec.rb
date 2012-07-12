require 'spec_helper'

describe Mapper::AttributeSet, '#loader_class' do
  subject { object.loader_class }

  it_should_behave_like 'an idempotent method'

  let(:object) { described_class.new }

  its(:superclass) { should be(Mapper::Transformer::Loader) }
end
