note
	description : "War of Raekidion - {IMAGE_FACTORY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	IMAGE_FACTORY

inherit
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
		local
			l_directory: STRING
			l_filename_c: C_STRING
			l_filename_list: LINKED_LIST[STRING]
		do
			l_directory := "resources/images/"
			directory_make (l_directory)
			create file_list.make
			create l_filename_list.make
			l_filename_list := list_files ("png")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				create l_filename_c.make (l_directory + l_filename_list.item)
				file_list.extend ([l_filename_list.item, {SDL_WRAPPER}.sdl_loadimage (l_filename_c.item)])
				l_filename_list.forth
			end

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		end

feature -- Access

	image (a_name: STRING): POINTER
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
					Result := file_list.item.object
				end

				file_list.forth
			end
		end

	dispose
		do
			from
				file_list.start
			until
				file_list.exhausted
			loop
				{SDL_WRAPPER}.sdl_freesurface (file_list.item.object)
				file_list.forth
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST[TUPLE[filename: STRING; object: POINTER]]

	is_init: CELL[BOOLEAN]
		once
			create result.put (false)
		end

end
