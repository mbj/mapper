require 'spec_helper'

describe Mapper::ClassMethods,'#instanciate_model' do
  let(:domain_model)  { mock }
  let(:attributes)    { mock }
  let(:domain_object) { mock }

  subject { object.instanciate_model(attributes) }

  context 'when model was set' do
    let(:object) do
      domain_model = self.domain_model
      Mapper.new do
        model(domain_model)
        map :foo, Object
      end
    end


    it 'should call .new on model with attributes and return created domain object' do
      domain_model.should_receive(:new).with(attributes).and_return(domain_object)
      should be(domain_object)
    end
  end

  context 'when model was NOT set' do
    let(:object) do
      Mapper.new do
        map :foo, Object
      end
    end

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError,"no model set for: #{object.class.inspect}")
    end
  end
end
