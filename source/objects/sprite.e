note
	description : "[
						War of Raekidion - A 2D sprite
						A {SPRITE} is a movable and animable image.
					]"
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
		-- Initialize `Current' from `a_name', `a_window', `a_x' and `a_y'
		do
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
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
		-- The angle at which the image is rotated

	default_image: STRING
		-- The default image (useful for animations)

	current_image: STRING
		-- The current image used for the sprite

	update
		-- Update `Current' on screen
		do
			if not hidden then
		    	{SDL}.sdl_rendercopyex (renderer, texture, create {POINTER}, targetarea, angle, create {POINTER}, {SDL}.sdl_flip_none)
			end
		end

feature -- Element change

	reset_image
		-- Reset `current_image' to `default_image'
		do
			set_image (default_image)
		end

	set_image (a_name: STRING)
		-- Set `current_image' to `a_name'
		do
			if a_name /= current_image then
				image := factory.image (a_name)

				if not image.is_default_pointer then
					set_x (x)
					set_y (y)
				    set_width ({SDL}.get_sdl_loadbmp_width (image))
				    set_height ({SDL}.get_sdl_loadbmp_height (image))
				    {SDL}.sdl_destroytexture (texture)
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
		-- The current image object

	factory: IMAGE_FACTORY
		-- The image factory containing all loaded images

	dispose
		-- Free the rectangle and texture from memory
		do
			{SDL}.sdl_destroytexture (texture)
			targetarea.memory_free
		end

end
