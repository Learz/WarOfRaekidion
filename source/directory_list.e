note
	description : "War of Raekidion - {DIRECTORY_LIST} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	DIRECTORY_LIST

feature

    list_files(a_path, a_type:STRING):LINKED_LIST[STRING]
    	local
			l_directory: DIRECTORY
    		l_filename: STRING
    		l_char_count: INTEGER
    		l_names_list: LINKED_LIST[STRING]
		do
			create l_directory.make_with_name (a_path)
			create l_names_list.make
			if a_type.is_equal ("all") then
				across l_directory.entries as ic loop
          			l_filename := ic.item.utf_8_name
          			l_names_list.force (l_filename)
				end
			else
				across l_directory.entries as ic loop
          			if ic.item.has_extension (a_type) then
          				l_filename := ic.item.utf_8_name
          				l_names_list.force (l_filename)
          			end
				end
			end
			Result := l_names_list
		end

end
