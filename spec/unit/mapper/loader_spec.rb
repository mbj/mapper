require 'spec_helper'

describe Mapper, '#loader' do
  subject { object.loader(domain_object) }

  let(:object)        { described_class.new(model, attributes)             }
  let(:model)         { mock('Model')                                     }
  let(:attributes)    { mock('Attributes', :loader_class => loader_class) }
  let(:loader)        { mock('Loader')                                    }
  let(:loader_class)  { mock('Loader Class', :new => loader)              }
  let(:domain_object) { mock('Domain Object')                             }

  it 'should instancitate a loader' do 
    loader_class.should_receive(:new).with(object, domain_object).and_return(loader)

    should be(loader)
  end

  it 'should return loader' do
    should be(loader)
  end
end
