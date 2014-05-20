note
	description	: "[
					War of Raekidion - An SQLite database manager
					A {DATABASE_MANAGER} is a medium for reading, writing 
					and managing a simple local or distant database.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	DATABASE_MANAGER

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		do
		end

feature {NONE} -- Implementation

	database: SQLITE_DATABASE
		-- The database to use

end
