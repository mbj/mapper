require 'spec_helper'

describe Mapper::Builder, '#loader' do
  subject { object.loader(&block) }

  let(:mapper_class) { mock('Mapper Class') }
  let(:model)        { mock('Model')        }

  let(:object) { described_class.new(mapper_class, model) }


  context 'without block' do
    let(:block) { nil }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError, 'block not supplied')
    end
  end

  context 'with block' do
    let(:block) do
      lambda do |context|
        def foo
          :bar
        end
      end
    end

    it_should_behave_like 'a command method'

    it 'should evaluate block in loader class context' do
      transformer = object.send(:loader_class)
      expect { subject }.to change { transformer.instance_methods.map(&:to_s).include?('foo') }.
        from(false).
        to(true)
    end
  end
end
