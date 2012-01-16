Pure Mapper
===========

An attempt to create a total agnostic mapper to transform business objects
into a DB compatible representations. And a database representation back to 
domain objects.

Terminology:
------------

There is a terminology clash since this mapper should be usable for 
RDBMS and NOSQL at the same time. Also the world of ruby programming 
clashes. You have been warned.

I decided to stick with the programming naming since this matches the names 
we all know from programming much better than the RDBMS terminology. 

Please refer to the following (still incomplete) table to make sure you get the
naming.

RDBMS  | Mongo      | Used in this document:
============================================
Table  | Collection | Collection
Record | Document   | Object

For my use case I can map 99% of my business objects to a first class mongo
collection member document. For RDBMS this could be much more complicated. 
This mapper interface is intend to be compatible with RDBMS, but since I 
not develop for RDBMS (anymore / regularly) I might missed substantial parts
of functionality.

Overview:
---------

Currently I'm thinking about mappers as DB/repository specific configurable 
decorators for domain objects.

The purpose is to map domain models into a universal database compatible 
intermediate representation and vice versa. I choose a intermediate format that
database adapters can easily transform into updates inserts or deletes.

The mapper exists to decouple the database representation from domain object 
as far as possible.

Breaking the 1:1 Mapping
------------------------

As we are all used ActiveRecord, we know the concept about one business-object 
corresponds to one row of a specific collection. A mapper should be able to 
break this.

Example (using an imaginary ORM library :D)

    class Address
      include GenericOrmLibrary
      attribute :city, String
      attribute :postcode, String
      attribute :country, String
    end

    class Person
      include GenericOrmLibrary
      attribute :id, Integer
      attribute :saluation, String
      attribute :firstname, String
      attribute :lastname, String
      attribute :address, Address
    end
    

Traditionally this would be mapped to two collections, "addresses" and "people",
with a foreign key referencing address id in person collection as an additional
column.

With a mapper it is possible to use the embedded value pattern to map this two 
models into one collection. For example the columns representing the address 
could be mapped/added to the person collection. Resulting in:

FIXME: Figure out how to make a table with markdown.

    Table People     
    ==========================
    Name             | Type
    --------------------------
    id               | Integer
    salutation       | String
    firstname        | String
    lastname         | String
    address_city     | String
    address_postcode | String
    address_country  | String


Also it is possible to map one business object to multiple collections. Also it
should be possible to map into a collection located in another 
database/repository. The latter is currently not possible and needs more 
thought. 

    # FIXME: as I do not used this pattern before I might use it wrong.
    # This is basically belongs_to :address from dm-1.0
    # I can also imagine the case someone whats to save a brunch of 
    # attributes in another collection, but im not very sure if this is not 
    # just only the same pattern with flat attributes instead of the explict 
    # address object.
    class Address
      include GenericOrmLibrary
      attribute :city, String
      attribute :postcode, String
      attribute :country, String
    end

    class Person
      include GenericOrmLibrary
      attribute :id, Integer
      attribute :saluation, String
      attribute :firstname, String
      attribute :lastname, String
      attribute :address, Address
    end

    Table People     
    ==========================
    Name             | Type
    --------------------------
    id               | Integer
    salutation       | String
    firstname        | String
    lastname         | String
    address_id       | Integer

    Table Addresses
    =========================
    Name             | Type
    -------------------------
    address_id       | String
    address_city     | String
    address_postcode | String
    address_country  | String

Implementation
--------------

If you call #dump(object) on a root level mapper you'll end up in a so called 
Intermediate Format that carries all information an adapter needs to write data 
into the database. The intermediate Format should be the same for all adapters.

The intermediate format has all information regarding hit collections, values 
for each collection and keys.

The mapper should not know if you are updating or inserting a record/object. It
should populate the intermediate format and let the adapter can decide. 

The same intermediate format is used when loading objects from database, only 
the key information is missing. Basically you should be able to round-trip the 
intermediate format ending up in a business object with exactly the same 
attributes and behaviour but new identity (object id). The Unit of Work session 
would have to take care about eliminating such duplicates in the first step.

Dirty-Tracking
--------------

The intermediate format could be saved when the business object had been loaded.
On updated the intermediate format could be compared with the saved one 
resulting in a clear update without any need to track state at the business 
object level. Yes this wastes space. But it is nice at an option.

Intermediate Format:
--------------------

To be documented. Will be implemented tomorrow, I'm thinking about an array of 
hashes, but maybe a specialized class can/should be created.
