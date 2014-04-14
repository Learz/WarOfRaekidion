note
	description : "War of Raekidion - {SPRITE} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	SPRITE

inherit
	SURFACE
	IMAGE_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			window := a_window
			default_image := a_name
			renderer := a_window.renderer
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			set_image (a_name)
			set_x (a_x)
			set_y (a_y)
		end

feature -- Access

	angle: DOUBLE

	update
		do
		    {SDL}.sdl_rendercopyex (renderer, texture, create {POINTER}, targetarea, angle, create {POINTER}, {SDL}.sdl_flip_none)
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
			    width := {SDL}.get_sdl_loadbmp_width (image).as_integer_16
			    height := {SDL}.get_sdl_loadbmp_height (image).as_integer_16
			    {SDL}.set_sdl_rect_w (targetarea, width)
			    {SDL}.set_sdl_rect_h (targetarea, height)
				texture := {SDL}.sdl_createtexturefromsurface(renderer, image)
			else
				width := 0
				height := 0
			    {SDL}.set_sdl_rect_w (targetarea, width)
			    {SDL}.set_sdl_rect_h (targetarea, height)
				texture := create {POINTER}
			end
		end

feature {NONE} -- Implementation

	image: POINTER
	imagefactory: IMAGE_FACTORY
	default_image: STRING

	dispose
		do
			{SDL}.sdl_destroytexture (texture)
			texture.memory_free
			targetarea.memory_free
		end

end
