require 'spec_helper'

describe Mapper::ClassMethods,'#wrap_query' do
  let(:object) { Mapper.new }

  subject { object.wrap_query }

  it 'should raise error' do
    expect { subject }.to raise_error(NotImplementedError,'::Mapper does not implement queries. See DB/query-system specific mappers')
  end
end
