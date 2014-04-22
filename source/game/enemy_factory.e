note
	description : "War of Raekidion - {ENEMY_FACTORY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	ENEMY_FACTORY

--inherit
--	DIRECTORY_LIST
--		rename
--			make as directory_make
--		end

create
	make

feature {NONE} -- Initialization

	make
		require
			is_not_already_initialised: not is_init.item
		local
--			l_directory: STRING
--			l_path: PATH
			l_enemy_properties: ENEMY_PROPERTIES
--			l_filename_list: LINKED_LIST[STRING]
--			l_xml_parser: XML_STANDARD_PARSER
		do
--			l_directory := "resources/ships/"
--			directory_make (l_directory)
			create file_list.make
--			create l_xml_parser.make
--			create l_filename_list.make
--			l_filename_list := list_files ("xml")

--			from
--				l_filename_list.start
--			until
--				l_filename_list.exhausted
--			loop
--				create l_path.make_from_string (l_directory + l_filename_list.item)
--				l_xml_parser.parse_from_path (l_path)
				create l_enemy_properties.make ("Sprayer", "Sprays bullets in a straight line right onto the player.", "Small laser", 1, 100, 2.5, 0.2, 0)
--				file_list.extend ([l_filename_list.item, l_enemy_properties])
				file_list.extend ([l_enemy_properties.name + ".xml", l_enemy_properties])
--				l_filename_list.forth
--			end

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		end

feature -- Access

	enemy (a_name: STRING): detachable ENEMY_PROPERTIES
		local
			l_count: NATURAL_16
			l_name: STRING
		do
			from
				file_list.start
			until
				file_list.exhausted
			loop
				l_count := file_list.item.filename.index_of ('.', 1).as_natural_16
				l_name := file_list.item.filename.substring (1, l_count - 1)

				if l_name.is_equal (a_name) then
					result := file_list.item.object
				end

				file_list.forth
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST[TUPLE[filename: STRING; object: ENEMY_PROPERTIES]]

	is_init: CELL[BOOLEAN]
		once
			create result.put (false)
		end

end
