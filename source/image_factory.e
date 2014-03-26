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

feature {NONE} -- Initialiation

	file_list: LINKED_LIST[TUPLE[filename: STRING; object: POINTER]]

	make
		require
			Is_Not_Already_Initialised: not is_init.item
		local
			l_filename_c: C_STRING
			l_filename_list: LINKED_LIST[STRING]
			l_tuple: TUPLE[STRING, POINTER]
		do
			directory_make ("resources/images")
			create file_list.make
			create l_filename_list.make
			l_filename_list := list_files("png")
			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				create l_tuple
				create l_filename_c.make ("resources/images/" + l_filename_list.item)
				l_tuple.put (l_filename_list.item, 1)
				l_tuple.put ({SDL_WRAPPER}.sdl_loadimage (l_filename_c.item), 2)
				file_list.extend (l_tuple)
				l_filename_list.forth
			end
		    is_init.replace(True)
		ensure
		   	Is_Initialised: is_init.item
		end

feature

	is_init:CELL[BOOLEAN]
		once
			create Result.put(False)
		end

	image(a_name:STRING):POINTER
		local
			l_count:INTEGER
			l_name:STRING
		do
			from
				file_list.start
			until
				file_list.exhausted
			loop
				l_count := file_list.item.filename.index_of ('.', 1)
				l_name := file_list.item.filename.substring (1, l_count - 1)

				if l_name.is_equal (a_name) then
					Result := file_list.item.object
				end

				file_list.forth
			end
		end

	destroy
		do
			from
				file_list.start
			until
				file_list.exhausted
			loop
				{SDL_WRAPPER}.sdl_freesurface(file_list.item.object)
				file_list.forth
			end
		end

end
