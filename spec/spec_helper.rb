$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'mapper'

Dir.glob('spec/examples/**/*.rb').each { |file| require File.expand_path(file) }

require 'rspec'
