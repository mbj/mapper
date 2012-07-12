require 'spec_helper'

# This spec makes shure the unless kind_of?(Veritas::Relation) branch in #forward is taken
describe Mapper::Veritas::Reader, '#empty?' do
  subject { object.empty? }

  let(:object) { described_class.new(mapper, relation) }

  let(:mapper)   { mock('Mapper') }
  let(:header)   { Veritas::Relation::Header.new([[:id, Integer]]) }
  let(:relation) { Veritas::Relation.new(header, data) }

  context 'when empty' do
    let(:data) { [] }
    it { should be(true) }
    it_should_behave_like 'an idempotent method'
  end

  context 'when NOT empty' do
    let(:data) { [[1]] }
    it { should be(false) }
    it_should_behave_like 'an idempotent method'
  end
end
