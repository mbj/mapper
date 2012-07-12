require 'spec_helper'

describe Mapper, '#load' do
  subject { object.load(dump) }

  let(:object)        { described_class.new(model, attributes)             }
  let(:model)         { mock('Model')                                     }
  let(:attributes)    { mock('Attributes', :loader_class => loader_class) }
  let(:loader_class)  { mock('Loader', :new => loader)                    }
  let(:loader)        { mock('Loader', :object => domain_object)          }
  let(:dump)          { mock('Dump')                                      }
  let(:domain_object) { mock('Domain Object')                             }

  it { should be(domain_object) }

  it 'should instantiate loader' do
    loader_class.should_receive(:new).with(object, dump).and_return(loader)

    should be(domain_object)
  end

  it 'should return object from loader' do
    loader.should_receive(:object).and_return(domain_object)

    should be(domain_object)
  end
end
