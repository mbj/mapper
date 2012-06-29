require 'spec_helper'

describe Mapper,'#dump' do
  subject { object.dump(dump) }

  let(:object)        { described_class.new(model,attributes) }
  let(:model)         { mock('Model')                         }
  let(:attributes)    { mock('Attributes')                    }
  let(:dumper)        { mock('Dumper', :dump => dump)         }
  let(:dump)          { mock('Dump')                          }
  let(:domain_object) { mock('Domain Object')                 }

  it 'should create dumper and returns its object' do
    object.should_receive(:dumper).with(dump).and_return(dumper)
    should be(dump)
  end
end
