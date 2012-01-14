module Mapper
  class Session
    def initialize(mapper)
      @mapper = mapper
      @insert,@update,@delete = {},{},{}
    end

    def commit
      do_inserts
    end

    def dump(object)
      @mapper.dump(object)
    end

    def loaded?(object)
      identity_map.key?(object_key(object))
    end

    def object_key(object)
      # FIXME: mapper has to find id!
      # Works only for mongo since ids are most likely to be
      # unique about all collections.
      object.id
    end

    def do_inserts
      @insert.keys.each do |object|
        do_insert(object)
        identity_map[object_key(object)]=object
        @insert.delete(object)
      end
    end

    def insert(object)
      assert_not_registred_for_update(object)
      assert_not_registred_for_delete(object)
      @insert[object] = true
      self
    end

    def assert_not_registred_for_update(object)
      raise if @delete.key?(object)
    end

    def assert_not_registred_for_delete(object)
      raise if @delete.key?(object)
    end

    def assert_not_registred_for_insert(object)
      raise if @delete.key?(object)
    end

    def identity_map
      @identity_map ||= {}
    end

  protected

    def do_insert(object)
      raise NotImplemented,'Implement in db specific subclass'
    end
  end
end
