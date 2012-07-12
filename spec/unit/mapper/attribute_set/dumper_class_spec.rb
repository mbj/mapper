require 'spec_helper'

describe Mapper::AttributeSet, '#dumper_class' do
  subject { object.dumper_class }

  it_should_behave_like 'an idempotent method'

  let(:object) { described_class.new }

  its(:superclass) { should be(Mapper::Transformer::Dumper) }
end
