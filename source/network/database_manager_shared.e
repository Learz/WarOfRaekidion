note
	description	: "[
					War of Raekidion - An SQLite database connexion
					A {DATABASE_MANAGER_SHARED} is a medium for reading, writing 
					and managing a simple local or distant database.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	DATABASE_MANAGER_SHARED

feature {NONE} -- Access

	connexion: DATABASE_MANAGER
		once
			create Result.make
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
