require 'spec_helper'

describe Mapper::ClassMethods,'#attributes' do

  subject { object.attributes }

  context 'when empty' do
    let(:object) do
      Mapper.new
    end

    it { should be_kind_of(Mapper::AttributeSet) }
    it { should be_empty }
  end
end
