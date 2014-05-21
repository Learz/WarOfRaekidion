note
	description	: "[
					War of Raekidion - An SQLite database manager
					A {DATABASE_MANAGER} is a singleton implementation of 
					a {DATABASE_CONNECT} to ensure it is only created once.
				]"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	DATABASE_MANAGER

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_source: SQLITE_FILE_SOURCE
			l_query: SQLITE_QUERY_STATEMENT
			l_modify: SQLITE_MODIFY_STATEMENT
		do
			create l_source.make ("resources/data")
			create database.make (l_source)
			database.open_create_read_write
			create l_query.make ("SELECT * FROM sqlite_master;", database)
			create l_modify.make ("CREATE TABLE IF NOT EXISTS scores (name TEXT, score INTEGER);", database)
			l_modify.execute
		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	database: SQLITE_DATABASE
		-- The database to use

	dispose
		-- Free and close the database
		do
			database.close
		end

	is_init: CELL [BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
		end

end