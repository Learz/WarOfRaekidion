note
	description : "[
					War of Raekidion - An image factory
					An {IMAGE_FACTORY} loads and stores every image file found in 
					the game's folders and puts them in a list.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	IMAGE_FACTORY

inherit
	LOADING
		rename
			make as loading_make
		redefine
			destroy
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
			l_filename_c: C_STRING
			l_filename_list: LINKED_LIST[STRING]
		do
			l_directory := "resources/images/"
			directory_make (l_directory)
			loading_make

			if attached a_splash_screen as la_splash then
				on_load.extend (agent la_splash.change_message)
				on_load.extend (agent la_splash.write_debug_file)
				on_debug_load.extend (agent la_splash.write_debug_file)
			end

			create file_list.make
			create l_filename_list.make
			l_filename_list := files_with_type ("png")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				loading_begin (l_filename_list.item)
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				create l_filename_c.make (l_directory + l_filename_list.item)
				file_list.extend ([l_name, {SDL}.sdl_loadimage (l_filename_c.item)])
				loading_done (l_filename_list.item)
				l_filename_list.forth
			end

			on_load.wipe_out
		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	image (a_name: STRING): POINTER
		-- Find a loaded image from `a_name'
		do
			from
				file_list.start
			until
				file_list.exhausted
			loop
				if file_list.item.filename.is_equal (a_name) then
					Result := file_list.item.object
				end

				file_list.forth
			end
		end

	destroy
		-- Free every image from memory
		do
			Precursor {LOADING}

			from
				file_list.start
			until
				file_list.exhausted
			loop
				{SDL}.sdl_freesurface (file_list.item.object)
				file_list.remove
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST [TUPLE [filename: STRING; object: POINTER]]
		-- The list of image files

	is_init: CELL [BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
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
