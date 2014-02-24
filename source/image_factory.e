note
	description : "War of Raekidion - {IMAGE_FACTORY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	IMAGE_FACTORY

inherit
	DIRECTORY_LIST

create
	make

feature {NONE}

	make
		require
			Is_Not_Already_Initialised: not is_init.item
		local
			l_filename_c:C_STRING
		do
			create objects.make
			filenames := list_files("ressources/images", "png")

			from
				filenames.start
			until
				filenames.exhausted
			loop
				create l_filename_c.make ("ressources/images/" + filenames.item)
		    	objects.force ({SDL_WRAPPER}.sdl_loadimage (l_filename_c.item))
		    	filenames.forth
			end

		    is_init.replace(True)
		ensure
		   	Is_Initialised: is_init.item
		end

feature

	filenames:LINKED_LIST[STRING]
	objects:LINKED_LIST[POINTER]

	is_init:CELL[BOOLEAN]
		once
			create Result.put(False)
		end

	get_image(a_name:STRING):POINTER
		local
			l_count:INTEGER
			l_name:STRING
		do
			from
				filenames.start
			until
				filenames.exhausted
			loop
				l_count := filenames.item.index_of ('.', 1)
				l_name := filenames.item.substring (1, l_count - 1)

				if l_name.is_equal (a_name) then
					Result := objects.at (filenames.index)
				end

				filenames.forth
			end
		end

	destroy_images
		do
			from
				objects.start
			until
				objects.exhausted
			loop
				{SDL_WRAPPER}.sdl_freesurface(objects.item)
				objects.forth
			end
		end

end
