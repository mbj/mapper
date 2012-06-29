require 'spec_helper'

describe Mapper,'#load' do
  subject { object.load(dump) }

  let(:object)        { described_class.new(model,attributes)    }
  let(:model)         { mock('Model')                            }
  let(:attributes)    { mock('Attributes')                       }
  let(:loader)        { mock('Loader', :object => domain_object) }
  let(:dump)          { mock('Dump')                             }
  let(:domain_object) { mock('Domain Object')                    }

  it 'should create loader and returns its object' do
    object.should_receive(:loader).with(dump).and_return(loader)
    should be(domain_object)
  end
end
