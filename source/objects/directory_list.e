note
	description : "[
						War of Raekidion - A basic directory listing
						A {DIRECTORY_LIST} generates a linked list 
						of filenames of a certain type in a directory.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	DIRECTORY_LIST

create
	make

feature {NONE} -- Initialization

	make (a_path: STRING)
		-- Initialize `Current' from directory `a_path'
		do
			create directory.make_with_name (a_path)
		end

feature -- Access

    list_files (a_type: STRING): LINKED_LIST[STRING]
    	-- Make a list of filenames of extension `a_type'
    	local
    		l_filename: STRING
    		l_names_list: LINKED_LIST[STRING]
		do
			create l_names_list.make
			if a_type.is_equal ("all") then
				across directory.entries as ic loop
          			l_filename := ic.item.utf_8_name
          			l_names_list.extend (l_filename)
				end
			else
				across directory.entries as ic loop
          			if ic.item.has_extension (a_type) then
          				l_filename := ic.item.utf_8_name
          				l_names_list.extend (l_filename)
          			end
				end
			end
			result := l_names_list
		end

feature {NONE} -- Implementation

	directory: DIRECTORY
		-- The directory for `Current'

end
