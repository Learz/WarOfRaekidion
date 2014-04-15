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
			current_image := ""
			factory := image_factory
			renderer := a_window.renderer
			set_image (a_name)
			set_x (a_x)
			set_y (a_y)
		end

feature -- Access

	angle: DOUBLE
	default_image, current_image: STRING

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
			if a_name /= current_image then
				image := factory.image (a_name)
				targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)

				if not image.is_default_pointer then
					set_x (x)
					set_y (y)
				    set_width ({SDL}.get_sdl_loadbmp_width (image))
				    set_height ({SDL}.get_sdl_loadbmp_height (image))
					texture := {SDL}.sdl_createtexturefromsurface (renderer, image)
					current_image := a_name
				else
					set_x (x)
					set_y (y)
				    set_width (0)
				    set_height (0)
					texture := create {POINTER}
					current_image := ""
				end
			end
		end

feature {NONE} -- Implementation

	image: POINTER
	factory: IMAGE_FACTORY

	dispose
		do
			{SDL}.sdl_destroytexture (texture)
			texture.memory_free
			targetarea.memory_free
		end

end
