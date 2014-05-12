note
	description : "[
						War of Raekidion - An image factory
						An {IMAGE_FACTORY} loads and stores every image file found in 
						the game's folders and puts them in a list.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	IMAGE_FACTORY

inherit
	DISPOSABLE
		select
			dispose
		end
	DIRECTORY_LIST
		rename
			make as directory_make,
			dispose as directory_dispose
		end

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		require
			is_not_already_initialised: not is_init.item
		local
			l_directory: STRING
			l_count: INTEGER
			l_name: STRING
			l_filename_c: C_STRING
			l_filename_list: LINKED_LIST[STRING]
		do
			l_directory := "resources/images/"
			directory_make (l_directory)
			create file_list.make
			create l_filename_list.make
			l_filename_list := files_with_type ("png")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				create l_filename_c.make (l_directory + l_filename_list.item)
				file_list.extend ([l_name, {SDL}.sdl_loadimage (l_filename_c.item)])
				l_filename_list.forth
			end

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
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

	dispose
		-- Free every image from memory
		do
			from
				file_list.start
			until
				file_list.exhausted
			loop
				file_list.item.object.memory_free
				{SDL}.sdl_freesurface (file_list.item.object)
				file_list.forth
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

end
