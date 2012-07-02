begin
  require 'rspec'  # try for RSpec 2
rescue LoadError
  require 'spec'   # try for RSpec 1
  RSpec = Spec::Runner
end

$LOAD_PATH << File.expand_path('../lib', __FILE__)

Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each { |f| require f }

# simple domain object used in specs
class DomainObject
  attr_reader :foo,:id

  def initialize(attributes={})
    @id = attributes.fetch(:id,1)
    @foo = attributes.fetch(:foo,:bar)
  end
end

require 'mapper'
require 'mapper/veritas'

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
