begin
  require 'rspec'  # try for RSpec 2
rescue LoadError
  require 'spec'   # try for RSpec 1
  RSpec = Spec::Runner
end

$LOAD_PATH << File.expand_path('../lib', __FILE__)

Dir.glob('spec/**/*_shared.rb').each { |file| require File.expand_path(file) }

# simple domain object used in specs
class DomainObject
  attr_reader :foo
  def initialize(attributes)
    @foo = attributes.fetch(:foo)
  end
end


module SpecHelper
  def compress_prefix(lines)
    lines = lines.split("\n")
    match = lines.first.match(/^[ ]*/)
    length = match.to_s.length
    lines.map do |line|
      line[length..-1]
    end.join("\n")
  end
end

RSpec.configure do |config|
  config.include SpecHelper
end

require 'mapper'
