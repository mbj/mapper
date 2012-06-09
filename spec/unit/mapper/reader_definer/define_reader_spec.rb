# encoding: utf-8

require 'spec_helper'

describe Mapper::ReaderDefiner, '#define_reader' do

  let(:object) do
    Class.new do
      extend Mapper::ReaderDefiner

    private

      def read(name)
        name
      end
    end
  end

  let(:instance) do
    object.new
  end

  let(:name) { :foo }

  subject { object.define_reader(name) }

  it_should_behave_like 'a command method'

  it 'creates a method #foo' do
    expect { subject }.to change { instance.respond_to?(:foo) }.
      from(false).
      to(true)
  end

  it 'defines #foo as #read(:foo)' do
    subject
    instance.foo.should == :foo
  end

  specification = proc do
    object.class_eval do
      def read(name)
        caller
      end
    end

    subject

    file, line = instance.foo.first.split(':')[0, 2]

    File.expand_path(file).should eql(File.expand_path('../../../../../lib/mapper/reader_definer.rb', __FILE__))
    line.to_i.should eql(17)
  end

  it 'sets the file and line number properly' do
    if RUBY_PLATFORM.include?('java')
      pending('Kernel#caller returns the incorrect line number in JRuby', &specification)
    else
      instance_eval(&specification)
    end
  end
end
