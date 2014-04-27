note
	description : "War of Raekidion - {PROJECTILE_FACTORY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	PROJECTILE_FACTORY

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
			l_projectile_properties: PROJECTILE_PROPERTIES
--			l_filename_list: LINKED_LIST[STRING]
--			l_xml_parser: XML_STANDARD_PARSER
		do
--			l_directory := "resources/projectiles/"
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
--				file_list.extend ([l_name, l_projectile_properties])
--				l_filename_list.forth
--			end

		-- TEMPORARY
			create l_projectile_properties.make ("White laser", "white_laser", "laser", 1, 4.5, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Red laser", "red_laser", "laser", 1, 3.0, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Blue bullet", "blue_bullet", "", 1, 2.0, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Small missile", "small_missile", "", 3, 1, true)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Yellow laser", "yellow_laser", "laser", 1, 5.0, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
		-- TEMPORARY

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		end

feature -- Access

	projectile (a_name: STRING): PROJECTILE_PROPERTIES
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
				create result.make ("", "", "", 0, 0, false)
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST[TUPLE[name: STRING; object: PROJECTILE_PROPERTIES]]

	is_init: CELL[BOOLEAN]
		once
			create result.put (false)
		end

end
