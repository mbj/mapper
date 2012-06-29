require 'spec_helper'

describe Mapper,'#loader' do
  subject { object.loader(domain_object) }

  let(:object)        { described_class.new(model,attributes) }
  let(:model)         { mock('Model')                         }
  let(:attributes)    { mock('Attributes')                    }
  let(:loader)        { mock('Loader')                        }
  let(:loader_class)  { mock('Loader Class',  :new => loader) }
  let(:domain_object) { mock('Domain Object')                 }

  before do
    object.stub(:loader_class => loader_class)
  end

  it 'should instancitate a loader' do 
    loader_class.should_receive(:new).with(object,domain_object)
    subject
  end

  it 'should return loader' do
    should be(loader)
  end
end
