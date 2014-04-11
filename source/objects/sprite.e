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
		do
			default_image := a_name
			window := a_window
			renderer := window.renderer
			targetarea := targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			set_image (a_name)
			set_x (a_x)
			set_y (a_y)
		end

feature -- Access

	width, height: INTEGER_16
	x, y, angle: DOUBLE

	update
		do
		    {SDL_WRAPPER}.sdl_rendercopyex (renderer, texture, create {POINTER}, targetarea, angle, create {POINTER}, {SDL_WRAPPER}.sdl_flip_none)
		end

feature -- Element change

	reset_image
		do
			set_image (default_image)
		end

	set_image (a_name: STRING)
		do
			imagefactory := factory
			image := imagefactory.image (a_name)

			if not image.is_default_pointer then
			    width := {SDL_WRAPPER}.get_sdl_loadbmp_width (image).as_integer_16
			    height := {SDL_WRAPPER}.get_sdl_loadbmp_height (image).as_integer_16
			    {SDL_WRAPPER}.set_sdl_rect_w (targetarea, width)
			    {SDL_WRAPPER}.set_sdl_rect_h (targetarea, height)
				texture := {SDL_WRAPPER}.sdl_createtexturefromsurface(renderer, image)
			else
				width := 0
				height := 0
			    {SDL_WRAPPER}.set_sdl_rect_w (targetarea, width)
			    {SDL_WRAPPER}.set_sdl_rect_h (targetarea, height)
				texture := create {POINTER}
			end
		end

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
	texture, targetarea, renderer, image: POINTER
	imagefactory: IMAGE_FACTORY
	default_image: STRING

	dispose
		do
			{SDL_WRAPPER}.sdl_destroytexture (texture)
			texture.memory_free
			targetarea.memory_free
		end

end
