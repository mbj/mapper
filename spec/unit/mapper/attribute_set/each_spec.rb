require 'spec_helper'

describe Mapper::AttributeSet, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)   { described_class.new }
  let(:yields)   { Set.new             }

  it_should_behave_like 'an #each method'

  let(:attribute_a) { Mapper::Attribute::Object.new(:foo) }
  let(:attribute_b) { Mapper::Attribute::Object.new(:bar) }

  before do
    object.add(attribute_a)
    object.add(attribute_b)
  end

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from(Set.new).
      to([ attribute_a, attribute_b ].to_set)
  end
end

