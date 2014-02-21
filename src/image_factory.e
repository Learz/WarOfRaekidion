note
	description: "Summary description for {IMAGE_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IMAGE_FACTORY

inherit
	ANY
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
			--create filenames.make
			create objects.make

			filenames := list_directory("./Graphics")

			from
				filenames.start
			until
				filenames.exhausted
			loop
				create l_filename_c.make ("Graphics/" + filenames.item + ".bmp")
		    	objects.force({SDL_WRAPPER}.sdl_loadbmp(l_filename_c.item))
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

	get_image(name:STRING):POINTER
		do
			from
				filenames.start
			until
				filenames.exhausted
			loop
				if
					filenames.item.is_equal (name)
				then
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
