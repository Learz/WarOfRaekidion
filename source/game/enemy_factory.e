note
	description	: "[
					War of Raekidion - An enemy factory
					An {ENEMY_FACTORY} contains a list of every enemy 
					type able to get spawned in the game screen.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	ENEMY_FACTORY

inherit
	DIRECTORY_LIST
		rename
			make as directory_make
		end

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_directory: STRING
			l_count: INTEGER
			l_name: STRING
			l_filename_list: LINKED_LIST[STRING]
			l_xml_file: XML_STANDARD_PARSER
			l_xml: XML_CALLBACKS_DOCUMENT
		do
			l_directory := "resources/ships/"
			directory_make (l_directory)
			create file_list.make
			create l_filename_list.make
			l_filename_list := files_with_type ("xml")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				create l_xml_file.make
				l_xml_file.parse_from_path (create {PATH}.make_from_string (l_directory + l_filename_list.item))
				create l_xml.make_null
				l_xml.set_source_parser (l_xml_file)
				file_list.extend ([l_name, parse_enemy (l_xml.document)])
				l_filename_list.forth
			end

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	file_list: LINKED_LIST[TUPLE[name: STRING; object: ENEMY_PROPERTIES]]
		-- The list for all the different loaded enemy properties

	enemy (a_name: STRING): ENEMY_PROPERTIES
		-- Return a loaded enemy type from `a_name'
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

	is_init: CELL[BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
		end

	parse_enemy (a_document: XML_DOCUMENT): ENEMY_PROPERTIES
		local
			l_name: STRING
			l_filename: STRING
			l_description: STRING
			l_bullet: STRING
			l_health: DOUBLE
			l_count: INTEGER
			l_firerate: INTEGER
			l_price: INTEGER
			l_spread: DOUBLE
			l_speed: DOUBLE
			l_aiming: BOOLEAN
		do
			l_name := process_node (a_document, "name")
			l_filename := process_node (a_document, "filename")
			l_description := process_node (a_document, "description")
			l_bullet := process_node (a_document, "bullet")
			l_health := process_node (a_document, "health").to_double
			l_count := process_node (a_document, "count").to_integer_32
			l_firerate := process_node (a_document, "firerate").to_integer_32
			l_price := process_node (a_document, "price").to_integer_32
			l_spread := process_node (a_document, "spread").to_double
			l_speed := process_node (a_document, "speed").to_double
			l_aiming := process_node (a_document, "aiming").to_boolean
			create result.make (l_name, l_filename, l_description, l_bullet, l_health, l_count, l_firerate, l_price, l_spread, l_speed, l_aiming)
		end

	process_node (a_document: XML_DOCUMENT; a_name: STRING): STRING
		do
			if a_document.has_element_by_name (a_name) and
			then attached a_document.element_by_name (a_name) as la_element and
			then attached la_element.text as la_text then
				result := la_text
			else
				result := ""
			end
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
