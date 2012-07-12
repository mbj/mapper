require 'spec_helper'

describe Mapper::Veritas, '#header' do
  subject { object.header }

  let(:object) { described_class.new(model, attributes, relation) }

  let(:model)      { mock('Model')                       }
  let(:attributes) { mock('Attributes')                  }
  let(:relation)   { mock('Relation', :header => header) }
  let(:header)     { mock('Header')                      }

  it_should_behave_like 'an idempotent method'

  it { should be(header) }
end
