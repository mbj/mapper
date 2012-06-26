require 'veritas'

module Mapper
  module Veritas
    module ClassMethods
      def relation_header
        header = []

        attributes.each do |attribute|
          attribute.load_names.each do |name|
            header << [name,String]
          end
        end

        header
      end
    end

    def self.included(descendant)
      descendant.send(:include,::Mapper)
      descendant.send(:extend,ClassMethods)
    end

  end
end
