note
	description : "[
						War of Raekidion - A simple animation
						An {ANIMABLE} will switch between a fixed set of 
						different frames with time.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ANIMABLE

inherit
	IMAGE_FACTORY_SHARED
	SURFACE
		redefine
			set_x,
			set_y,
			set_width,
			set_height
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_frames, a_time: INTEGER; a_window: WINDOW; a_x, a_y: DOUBLE; a_repeat: BOOLEAN)
		-- Initialize `Current'
		do
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			sizearea := sizearea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			frames := a_frames
			time := a_time
			window := a_window
			factory := image_factory
			renderer := a_window.renderer
			image := factory.image (a_name)
			repeat := a_repeat

			if not image.is_default_pointer then
				set_x (a_x)
				set_y (a_y)
				set_width (({SDL}.get_sdl_loadbmp_width (image) / frames).floor)
				set_height (({SDL}.get_sdl_loadbmp_height (image) / frames).floor)
				texture := {SDL}.sdl_createtexturefromsurface (renderer, image)
			end
		end

feature -- Access

	lifetime: INTEGER
		-- Total time the animation has been running

	time: INTEGER
		-- Animation time

	frames: INTEGER
		-- Number of frames to animate

	update
		-- Update current frame
		do
		    {SDL}.sdl_rendercopy (renderer, texture, targetarea, sizearea)
		    lifetime := lifetime + 1

		    if lifetime >= time then
		    	if not repeat then
		    		destroy
		    	else
		    		lifetime := 0
		    	end
		    end
		end

	destroy
		do
			is_destroyed := true
		end

feature -- Status

	repeat, is_destroyed: BOOLEAN

feature -- Element change

	set_x (a_x: DOUBLE)
		-- Change `x' to `a_x'
		do
			x := a_x
			{SDL}.set_sdl_rect_x (sizearea, a_x.floor)
			{SDL}.set_sdl_rect_x (targetarea, a_x.floor + (width * (frames - 1)))
		end

	set_y (a_y: DOUBLE)
		-- Change `y' to `a_y'
		do
			y := a_y
			{SDL}.set_sdl_rect_y (sizearea, a_y.floor)
			{SDL}.set_sdl_rect_x (targetarea, a_y.floor)
		end

feature {NONE} -- Implementation

	sizearea: POINTER
		-- The current shown frame

	image: POINTER
		-- The current image object

	factory: IMAGE_FACTORY
		-- The image factory containing all loaded images

	set_width (a_width: INTEGER)
		-- Change `width' to `a_width'
		require else
			frames_not_null: frames > 0
		do
			{SDL}.set_sdl_rect_w (sizearea, a_width)
			{SDL}.set_sdl_rect_w (targetarea, (a_width / frames).floor)
		end

	set_height (a_height: INTEGER)
		-- Change `height' to `a_height'
		do
			{SDL}.set_sdl_rect_h (sizearea, a_height)
			{SDL}.set_sdl_rect_h (targetarea, a_height)
		end

	dispose
		-- Free the rectangle and texture from memory
		do
			image.memory_free
			{SDL}.sdl_destroytexture (texture)
			texture.memory_free
			targetarea.memory_free
			sizearea.memory_free
		end

invariant

	frames_not_null: frames > 0
	time_not_null: time > 0

end
