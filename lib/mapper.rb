require 'backports'
require 'virtus'

module Mapper
  Undefined = Object.new.freeze

  def self.included(descendant)
    descendant.extend(ClassMethods)
  end
end

require 'mapper/class_methods'
require 'mapper/transformer'
require 'mapper/attribute'
require 'mapper/attribute/object'
require 'mapper/attribute/embedded'
require 'mapper/attribute/embedded_document'
require 'mapper/attribute/embedded_collection'
require 'mapper/attribute/custom'
require 'mapper/attribute_set'
