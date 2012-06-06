require 'spec_helper'

describe Mapper::ClassMethods,'#model' do
  let(:model) { mock }

  subject { object.model }

  context 'when model was not specified' do
    let(:object) do
      Mapper.new {}
    end

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError,"no model set for: #{object.class.inspect}")
    end
  end

  context 'when model was specified' do
    let(:object) do
      model = self.model
      Mapper.new do
        model(model)
      end
    end

    it 'should return model' do
      should be(model)
    end
  end
end
