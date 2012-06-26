require 'spec_helper'

describe Mapper,'.new_mapper' do

  let(:object) { Mapper }

  subject { object.new_mapper }

  its(:ancestors) { should include(::Mapper) }
end
