note
	description: "Summary description for {IMAGE_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IMAGE_FACTORY

inherit
	ANY

create
	make

feature {NONE}

	make(a_renderer:POINTER)
		require
			Is_Not_Already_Initialised: not is_init.item
		local
			l_filename_c:C_STRING
			l_surface:POINTER
		do
			create filenames.make
			create objects.make

			filenames.force ("sidebar")
			filenames.force ("ship")
			filenames.force ("sbullet")

			from
				filenames.start
			until
				filenames.exhausted
			loop
				create l_filename_c.make ("Graphics/" + filenames.item + ".bmp")
				l_surface:={SDL_WRAPPER}.sdl_loadbmp(l_filename_c.item)
		    	{SDL_WRAPPER}.sdl_setcolorkey_noreturn (l_surface, {SDL_WRAPPER}.sdl_true, {SDL_WRAPPER}.sdl_maprgb({SDL_WRAPPER}.get_sdl_surface_format(l_surface), 255, 0, 255))
		    	objects.force({SDL_WRAPPER}.sdl_createtexturefromsurface(a_renderer,l_surface))
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
		require
			filenames.has (name)
		do
			Result := objects.at (filenames.index_of (name, 0))
		end

end
