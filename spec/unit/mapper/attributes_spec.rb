require 'spec_helper'

describe Mapper,'#attributes' do
  subject { object.attributes }

  let(:object)     { described_class.new(model,attributes) }
  let(:model)      { mock('Model')                         }
  let(:attributes) { mock('Attributes')                    }

  it 'should return attributes' do
    should be(attributes)
  end

 it_should_behave_like 'an idempotent method'
end
