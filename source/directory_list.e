note
	description : "War of Raekidion - {DIRECTORY_LIST} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	DIRECTORY_LIST

create
	make

feature {NONE} -- Initialisation

	directory: DIRECTORY

	make(a_path:STRING)
		do
			create directory.make_with_name (a_path)
		end

feature -- Getters

    list_files(a_type:STRING):LINKED_LIST[STRING]
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
			Result := l_names_list
		end

end
