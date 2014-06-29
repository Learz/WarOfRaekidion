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
	LOADING
		rename
			make as loading_make
		end
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

	make (a_splash_screen: detachable SPLASH_SCREEN)
		-- Initialize `Current' from `a_splash_screen'
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_directory: STRING
			l_count: INTEGER
			l_name: STRING
			l_filename_list: LINKED_LIST[STRING]
		do
			l_directory := "resources/ships/"
			directory_make (l_directory)
			document_make
			loading_make
			fill_default

			if attached a_splash_screen as la_splash then
				on_load.extend (agent la_splash.change_message)
				on_load.extend (agent la_splash.write_debug_file)
				on_debug_load.extend (agent la_splash.write_debug_file)
			end

			create file_list.make
			create l_filename_list.make
			l_filename_list := files_with_type ("xml")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				loading_begin (l_filename_list.item)
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				parse_from_filename (l_directory + l_filename_list.item)

				if attached parse_enemy as la_enemy then
					if attached get_default_file_hash (l_name) as la_hash then
						if not loading_check (create {PLAIN_TEXT_FILE}.make_with_path (create {PATH}.make_from_string (l_directory + l_filename_list.item)), la_hash) then
							cheat_mode := true
						end
					end

					file_list.extend ([l_name, la_enemy])
					loading_done (l_filename_list.item)
					l_filename_list.forth
				end
			end

			on_load.wipe_out
		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	file_list: LINKED_LIST [TUPLE [name: STRING; object: ENEMY_PROPERTIES]]
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
				create result.make ("", "", "", "", "", 0, 0, 0, 0, 0, 0, false)
			end
		end

feature {NONE} -- Implementation

	default_files: LINKED_LIST [TUPLE [name, hash: STRING]]
		-- List of default files and their MD5 hashes

	fill_default
		do
			create default_files.make
			default_files.extend (["barrage", "C5342A9A4647C70041682783C5782CA2"])
			default_files.extend (["homing",  "90DDA9D9140E3014359DD530F1F058FD"])
			default_files.extend (["laser",   "301C98BBC34CDFDB3308C64DB939D2E6"])
			default_files.extend (["mauler",  "F2E18BF41CFC07D5697D3011C26F0042"])
			default_files.extend (["spiral",  "764C283989190AD2C97FF535DB21C223"])
			default_files.extend (["sprayer", "068CBA9229E59DEFDFDC4BA9F173FC93"])
		end


	get_default_file_hash (a_name: STRING): detachable STRING
		-- Return a MD5 hash of a default file
		local
			l_found: BOOLEAN
		do
			from
				l_found := false
				default_files.start
			until
				l_found or
				default_files.exhausted
			loop
				if default_files.item.name.is_equal (a_name) then
					l_found := true
				end

				default_files.forth
			end

			if l_found then
				default_files.back
				result := default_files.item.hash
			else
				result := void
			end
		end

	is_init: CELL[BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
		end

	parse_enemy: detachable ENEMY_PROPERTIES
		local
			l_name: STRING
			l_filename: STRING
			l_description: STRING
			l_bullet: STRING
			l_sound: STRING
			l_health: DOUBLE
			l_count: INTEGER
			l_firerate: INTEGER
			l_price: INTEGER
			l_spread: DOUBLE
			l_speed: DOUBLE
			l_aiming: BOOLEAN
		do
			if attached process_node ("name") as la_name_element and then attached la_name_element.text as la_name then
				l_name := la_name

				if attached process_node ("filename") as la_element and then attached la_element.text as la_text then
					l_filename := la_text
				else
					l_filename := ""
				end

				if attached process_node ("description") as la_element and then attached la_element.text as la_text then
					l_description := la_text
				else
					l_description := ""
				end

				if attached process_node ("bullet") as la_element and then attached la_element.text as la_text then
					l_bullet := la_text
				else
					l_bullet := ""
				end

				if attached process_node ("sound") as la_element and then attached la_element.text as la_text then
					l_sound := la_text
				else
					l_sound := ""
				end

				if attached process_node ("health") as la_element and then attached la_element.text as la_text and then la_text.is_double then
					l_health := la_text.to_double
				end

				if attached process_node ("count") as la_element and then attached la_element.text as la_text and then la_text.is_integer then
					l_count := la_text.to_integer_32
				end

				if attached process_node ("firerate") as la_element and then attached la_element.text as la_text and then la_text.is_integer then
					l_firerate := la_text.to_integer_32
				end

				if attached process_node ("price") as la_element and then attached la_element.text as la_text and then la_text.is_integer then
					l_price := la_text.to_integer_32
				end

				if attached process_node ("spread") as la_element and then attached la_element.text as la_text and then la_text.is_double then
					l_spread := la_text.to_double
				end

				if attached process_node ("speed") as la_element and then attached la_element.text as la_text and then la_text.is_double then
					l_speed := la_text.to_double
				end

				if attached process_node ("aiming") as la_element and then attached la_element.text as la_text and then la_text.is_boolean then
					l_aiming := la_text.to_boolean
				end

				create Result.make (l_name, l_filename, l_description, l_bullet, l_sound, l_health, l_count, l_firerate, l_price, l_spread, l_speed, l_aiming)
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
