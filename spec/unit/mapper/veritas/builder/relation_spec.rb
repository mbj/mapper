require 'spec_helper'

describe Mapper::Veritas::Builder,'#relation' do
  subject { object.relation(relation) }

  let(:object)       { described_class.new(model,mapper_class) }
  let(:model)        { mock('Model')                           }
  let(:mapper_class) { mock('Mapper Class')                    }
  let(:relation)     { mock('Relation')                        }

  it_should_behave_like 'a command method'
end
