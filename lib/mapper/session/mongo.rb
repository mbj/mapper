module Mapper
  class Session
    class Mongo < Session
      attr_reader :db

      def initialize(mapper,db)
        super(mapper)
        @db = db
      end

      def get(model,id)
        identity_map[id] || first(model,:_id => id)
      end

      def reload(object)
        get(object.class,object.id)
      end

      def do_insert(object)
        collection_name = @mapper.repository_name(object.class)
        doc = dump(object)

        collection = @db.collection(collection_name)
        collection.insert(doc)
      end

      def collection(model)
        @db.collection(collection_name(model))
      end

      def collection_name(model)
        @mapper.repository_name(model)
      end

      # The query logic below is just a stub.
      def first(model,query,options={})
        options[:limit] = 1
        all(model,query,options).first
      end
     
      def all_from_cursor(model,cursor)
        cursor.map do |doc|
          id = doc.fetch('_id')
          identity_map[id] ||= @mapper.load(model,doc)
        end
      end
     
      def all(model,query,options={})
        cursor = collection(model).find(query,options)
        all_from_cursor(model,cursor)
      end
    end
  end
end
