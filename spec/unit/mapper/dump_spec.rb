require 'spec_helper'

describe Mapper, '#dump' do
  subject { object.dump(domain_object) }

  let(:object)        { described_class.new(model, attributes)             }
  let(:model)         { mock('Model')                                     }
  let(:attributes)    { mock('Attributes', :dumper_class => dumper_class) }
  let(:dumper_class)  { mock('Dumper Class', :new => dumper)              }
  let(:dumper)        { mock('Dumper', :dump => dump)                     }
  let(:dump)          { mock('Dump')                                      }
  let(:domain_object) { mock('Domain Object')                             }

  it { should be(dump) }

  it 'should instantiate dumper' do
    dumper_class.should_receive(:new).with(object, domain_object).and_return(dumper)

    should be(dump)
  end

  it 'should return dump from dumper' do
    dumper.should_receive(:dump).and_return(dump)

    should be(dump)
  end
end
