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
			create l_enemy_properties.make ("Sprayer", "sprayer", "Sprays bullets in a straight line right onto the player.", "Red laser", 20, 1, 40, 15, 0, 2.5, true)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Mauler", "mauler", "Hauls huge chunks of bullets at you, shotgun-style.", "Blue bullet", 25, 8, 140, 25, 30, 1.5, true)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Homing", "homing", "Shoots homing missiles by pair of two.", "Small missile", 30, 1, 80, 65, 45, 2.0, false)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Laser", "laser", "Fires a deadly bullet ray to burn through your ship.", "Yellow laser", 25, 1, 15, 75, 0, 2.5, true)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Spiral", "spiral", "A ship that does not aim, but hoots in a spiraling pattern.", "Red bullet", 45, 1, 5, 90, {DOUBLE_MATH}.pi, 1.0, false)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
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
				if file_list.item.name.is_equal (a_name) then
					l_found := true
				end

				file_list.forth
			end

			if l_found then
				file_list.back
				result := file_list.item.object
			else
				create result.make ("", "", "", "", 0, 0, 0, 0, 0, 0, false)
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST[TUPLE[name: STRING; object: ENEMY_PROPERTIES]]

	is_init: CELL[BOOLEAN]
		once
			create result.put (false)
		end

end
