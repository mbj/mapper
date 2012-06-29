require 'spec_helper'

describe Mapper,'#dumper' do
  subject { object.dumper(domain_object) }

  let(:object)        { described_class.new(model,attributes) }
  let(:model)         { mock('Model')                         }
  let(:attributes)    { mock('Attributes')                    }
  let(:dumper)        { mock('Dumper')                        }
  let(:dumper_class)  { mock('Dumper Class',  :new => dumper) }
  let(:domain_object) { mock('Domain Object')                 }

  before do
    object.stub(:dumper_class => dumper_class)
  end

  it 'should instancitate a dumper' do 
    dumper_class.should_receive(:new).with(object,domain_object)
    subject
  end

  it 'should return dumper' do
    should be(dumper)
  end
end
