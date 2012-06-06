require 'spec_helper'

describe Mapper::Transformer::Dumper,'#object' do
  let(:object) { described_class.new(domain_object) }
  let(:domain_object) { mock }

  subject { object.object }

  it 'should return wrapped object' do
    should be(domain_object)
  end
end
