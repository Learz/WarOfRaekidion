note
	description	: "[
					War of Raekidion - An SQLite database connexion
					A {DATABASE_MANAGER_SHARED} is a medium for reading, writing 
					and managing a simple local or distant database.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	DATABASE_MANAGER_SHARED

feature {NONE} -- Access

	connexion: DATABASE_MANAGER
		once
			create Result.make
		end

end
