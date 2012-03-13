# Todo get a rid on the db argument!

module Mapper
  class Mapper
    class Mongo < Mapper
      def initialize(options)
        @mapper     = ::Mapper.fetch_option(options,:mapper)
        @collection = ::Mapper.fetch_option(options,:collection)
      end

      def insert_dump(dump)
        @collection.insert(dump)
      end

      def insert_object(object)
        insert_dump(dump(object))
      end

      def extract_key_from_query(query)
        if query.keys.sort == @mapper.key_attributes.map(&:dump_name).sort
          query
        end
      end

      def first_dump(query)
        dump = @collection.find_one(query)
        if dump
          ::MApper.symbolize_keys(dump)
        end
      end

      def read_dumps(query_or_cursor)
        cursor = 
          if query_or_cursor.kind_of?(::Mongo::Cursor)
            query_or_cursor
          else
            @collection.find(query_or_cursor)
          end

        Enumerator.new do |yielder|
          dump = ::Mapper.symbolize_keys(cursor.next)
          yielder.yield(dump)
        end
      end

      def read_objects(query_or_cursor)
        dumps = read_dumps(query_or_cursor)
        Enumerator.new do |yielder|
          resource = load(dumps.next)
          yielder.yield(resource)
        end
      end

      def delete_key(key)
        @collection.remove(key)
      end

      def delete_object(object)
        delete_key(dump_key(object))
      end

      # TODO
      #
      # Create a deep tree diff of the update and use the atomic operators 
      # on demand.
      #
      def update_dump(key,dump,old_dump=nil)
        if old_dump.nil?
          @collection.update(key,dump)
        else
          change = {}
          dump.each do |name,value|
            old_value = old_dump[name]
            if value != old_value
              change[name]=value
            end
          end
          @collection.update(key,{ :$set => change })
        end
      end

      def update_object(object)
        update_dump(dump_key(object),dump(object))
      end

      def dump(object)
        @mapper.dump(object)
      end

      def dump_key(object)
        @mapper.dump_key(object)
      end

      def load(dump)
        @mapper.load(dump)
      end

      def load_key(dump)
        @mapper.load_key(dump)
      end
    end
  end
end
