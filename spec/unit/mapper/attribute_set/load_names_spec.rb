require 'spec_helper'

describe Mapper::AttributeSet,'#load_names' do
  let(:object) { described_class.new }

  subject { object.load_names }

  context 'when empty' do
    it { should be_empty }
  end
end
