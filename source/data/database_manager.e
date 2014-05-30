note
	description	: "[
					War of Raekidion - An SQLite database manager
					A {DATABASE_MANAGER} is a singleton implementation of 
					a {DATABASE_CONNECT} to ensure it is only created once.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	DATABASE_MANAGER

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_query: SQLITE_QUERY_STATEMENT
			l_modify: SQLITE_MODIFY_STATEMENT
		do
			create database.make_create_read_write ("resources/data")
			create l_query.make ("SELECT * FROM sqlite_master;", database)
			create l_modify.make ("CREATE TABLE IF NOT EXISTS scores (name TEXT, difficulty INTEGER, score INTEGER);", database)
			l_modify.execute
		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	database: SQLITE_DATABASE
		-- The database to use

	destroy
		-- Free and close the database
		do
			database.close
		end

	is_init: CELL [BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
