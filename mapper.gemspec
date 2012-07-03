# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mapper/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'mapper'
  s.version = Mapper::VERSION.dup

  s.authors  = ['Markus Schirp']
  s.email    = 'mbj@seonic.net'
  s.date     = '2012-02-14'
  s.summary  = 'Agnostic Mapper'
  s.homepage = 'http://github.com/mbj/mapper'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)

  s.rubygems_version = '1.8.10'

  s.add_dependency 'backports' 

  # These dependencies will be readded as dev deps once
  # the {Virtus,Veritas}::Support parts are ripped out into a support gem
  s.add_dependency 'virtus', '~> 0.5.1'
  s.add_dependency 'veritas', '~> 0.0.7'
end
