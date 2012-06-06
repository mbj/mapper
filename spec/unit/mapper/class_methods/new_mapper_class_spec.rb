require 'spec_helper'

describe Mapper,'.new_mapper_class' do

  let(:object) { Mapper }

  subject { object.new_mapper_class }

  its(:superclass) { should be(Object) }
  its(:ancestors) { should include(::Mapper) }
end
