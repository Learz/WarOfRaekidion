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
--			l_count: INTEGER
--			l_name: STRING
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
--				l_count := l_filename_list.item.index_of ('.', 1)
--				l_name := l_filename_list.item.substring (1, l_count - 1)
--				file_list.extend ([l_filename_list.item, l_enemy_properties])
--				l_filename_list.forth
--			end

		-- TEMPORARY
			create l_enemy_properties.make ("Sprayer", "sprayer", "Sprays bullets in a straight line right onto the player.", "small_laser", 100, 1, 0.2, 0, 2.5)
			file_list.force ([l_enemy_properties.filename, l_enemy_properties])
			create l_enemy_properties.make ("Mauler", "mauler", "Hauls huge chunks of bullets at you, shotgun-style.", "small_bullet", 150, 10, 1, 20, 2)
			file_list.force ([l_enemy_properties.filename, l_enemy_properties])
		-- TEMPORARY

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		end

feature -- Access

	enemy (a_name: STRING): ENEMY_PROPERTIES
		local
			l_found: BOOLEAN
		do
			from
				l_found := false
				file_list.start
			until
				l_found or
				file_list.exhausted
			loop
				if file_list.item.filename.is_equal (a_name) then
					l_found := true
				end

				file_list.forth
			end

			if l_found then
				file_list.back
				result := file_list.item.object
			else
				create result.make ("", "", "", "", 0, 0, 0, 0, 0)
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST[TUPLE[filename: STRING; object: ENEMY_PROPERTIES]]

	is_init: CELL[BOOLEAN]
		once
			create result.put (false)
		end

end
