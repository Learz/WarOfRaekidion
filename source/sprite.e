note
	description : "War of Raekidion - {SPRITE} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	SPRITE

inherit
	IMAGE_FACTORY_SHARED
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		local
			l_image: POINTER
			l_imagefactory: IMAGE_FACTORY
		do
			window := a_window
			renderer := window.renderer
			targetarea := targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			l_imagefactory := factory
			l_image := l_imagefactory.image (a_name)

			if not l_image.is_default_pointer then
			    set_x (a_x)
			    set_y (a_y)
			    width := {SDL_WRAPPER}.get_sdl_loadbmp_width (l_image).as_integer_16
			    height := {SDL_WRAPPER}.get_sdl_loadbmp_height (l_image).as_integer_16
			    {SDL_WRAPPER}.set_sdl_rect_w (targetarea, width)
			    {SDL_WRAPPER}.set_sdl_rect_h (targetarea, height)
				texture := {SDL_WRAPPER}.sdl_createtexturefromsurface(renderer, l_image)
			else
				set_x (0)
				set_y (0)
				width := 0
				height := 0
			    {SDL_WRAPPER}.set_sdl_rect_w (targetarea, width)
			    {SDL_WRAPPER}.set_sdl_rect_h (targetarea, height)
				texture := create {POINTER}
			end
		end

feature -- Access

	width, height: INTEGER_16
	x, y: DOUBLE

	update
		do
		    {SDL_WRAPPER}.sdl_rendercopy (renderer, texture, create {POINTER}, targetarea)
		end

feature -- Element change

	set_x (a_x: DOUBLE)
		do
			x := a_x
			{SDL_WRAPPER}.set_sdl_rect_x (targetarea, a_x.floor)
		end

	set_y (a_y: DOUBLE)
		do
			y := a_y
			{SDL_WRAPPER}.set_sdl_rect_y (targetarea, a_y.floor)
		end

feature {NONE} -- Implementation

	window: WINDOW
	texture, targetarea, renderer: POINTER

	dispose
		do
			{SDL_WRAPPER}.sdl_destroytexture (texture)
			targetarea.memory_free
		end

end
