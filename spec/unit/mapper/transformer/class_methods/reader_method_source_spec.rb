require 'spec_helper'

describe Mapper::Transformer,'.reader_method_source' do
  let(:object) { described_class }

  subject { object.reader_method_source(name) }

  let(:name) { :foo }

  it 'should return correct ruby' do
    compress_prefix(subject).should == compress_prefix(<<-RUBY)
      def foo
        read(:foo)
      end
    RUBY
  end
end
