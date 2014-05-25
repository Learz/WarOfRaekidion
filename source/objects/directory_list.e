note
	description : "[
					War of Raekidion - A basic directory listing
					A {DIRECTORY_LIST} generates a linked list 
					of filenames of a certain type in a directory.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	DIRECTORY_LIST

inherit
	DIRECTORY

create
	make

feature -- Access

    files_with_type (a_type: STRING): LINKED_LIST[STRING]
    	-- Make a list of filenames of extension `a_type'
    	local
    		l_filename: STRING
    		l_names_list: LINKED_LIST[STRING]
		do
			create l_names_list.make

			if a_type.is_equal ("all") then
				across entries as ic loop
          			l_filename := ic.item.utf_8_name
          			l_names_list.extend (l_filename)
				end
			else
				across entries as ic loop
          			if ic.item.has_extension (a_type) then
          				l_filename := ic.item.utf_8_name
          				l_names_list.extend (l_filename)
          			end
				end
			end

			result := l_names_list
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
