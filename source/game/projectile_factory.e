note
	description	: "[
					War of Raekidion - A projectile factory
					A {PROJECTILE_FACTORY} contains a list of every  
					projectile type able to get spawned in the game screen.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	PROJECTILE_FACTORY

inherit
	XML_DOCUMENT_PARSER
		rename
			make as document_make
		end
	DIRECTORY_LIST
		rename
			make as directory_make
		end

create
	make

feature {NONE} -- Initialization

	make
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_directory: STRING
			l_count: INTEGER
			l_name: STRING
			l_filename_list: LINKED_LIST[STRING]
		do
			l_directory := "resources/projectiles/"
			directory_make (l_directory)
			document_make
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
				parse_from_filename (l_directory + l_filename_list.item)

				if attached parse_projectile as la_projectile then
					file_list.extend ([l_name, la_projectile])
					l_filename_list.forth
				end
			end

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	projectile (a_name: STRING): PROJECTILE_PROPERTIES
		-- Return a loaded projectile type from `a_name'
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
				create result.make ("", "", "", 0, 0, false, 0, false)
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST[TUPLE[name: STRING; object: PROJECTILE_PROPERTIES]]
		-- The list for all the different loaded projectile properties

	is_init: CELL[BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
		end

	parse_projectile: detachable PROJECTILE_PROPERTIES
		local
			l_name: STRING
			l_filename: STRING
			l_sound: STRING
			l_damage: DOUBLE
			l_speed: DOUBLE
			l_homing: BOOLEAN
			l_lifetime: INTEGER
			l_explodes: BOOLEAN
		do
			if attached process_node ("name") as la_name then
				l_name := la_name

				if attached process_node ("filename") as la_text then
					l_filename := la_text
				else
					l_filename := ""
				end

				if attached process_node ("sound") as la_text then
					l_sound := la_text
				else
					l_sound := ""
				end

				if attached process_node ("damage") as la_text then
					l_damage := la_text.to_double
				end

				if attached process_node ("speed") as la_text then
					l_speed := la_text.to_double
				end

				if attached process_node ("homing") as la_text then
					l_homing := la_text.to_boolean
				end

				if attached process_node ("lifetime") as la_text then
					l_lifetime := la_text.to_integer_32
				end

				if attached process_node ("explodes") as la_text then
					l_explodes := la_text.to_boolean
				end

				create Result.make (l_name, l_filename, l_sound, l_damage, l_speed, l_homing, l_lifetime, l_explodes)
			else
				Result := Void
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
