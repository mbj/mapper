require 'spec_helper'

describe Mapper::AttributeSet,'#dump_names' do
  let(:object) { described_class.new }

  subject { object.dump_names }

  context 'when empty' do
    it { should be_empty }
  end
end
