note
	description : "[
						War of Raekidion - A rendered text
						A {TEXT} is a rendered texture that can be directly
						applied to a rectangle.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXT

inherit
	SURFACE

create
	make,
	make_centered,
	make_empty

feature {NONE} -- Initialization

	make (a_name: STRING; a_size: INTEGER; a_window: WINDOW; a_x, a_y: DOUBLE; a_color: TUPLE [r, g, b: INTEGER]; a_shadow: BOOLEAN)
		-- Initialize `Current'
		do
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			window := a_window
			renderer := a_window.renderer
			shadow := a_shadow
			color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
			{SDL_TTF}.set_red (color, a_color.r.as_natural_8)
			{SDL_TTF}.set_green (color, a_color.g.as_natural_8)
			{SDL_TTF}.set_blue (color, a_color.b.as_natural_8)

			if shadow then
				bg_targetarea := bg_targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
				bg_color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
				{SDL_TTF}.set_red (bg_color, 0)
				{SDL_TTF}.set_green (bg_color, 0)
				{SDL_TTF}.set_blue (bg_color, 0)
			end

			text := a_name
			size := a_size
			set_text (a_name, a_size)
			set_x (a_x)
			set_y (a_y)
		end

	make_centered (a_name: STRING; a_size: INTEGER; a_window: WINDOW; a_x, a_y, a_width, a_height: DOUBLE; a_color: TUPLE [r, g, b: INTEGER]; a_shadow: BOOLEAN)
		-- Initialize `Current' centered
		do
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			window := a_window
			renderer := a_window.renderer
			shadow := a_shadow
			color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
			{SDL_TTF}.set_red (color, a_color.r.as_natural_8)
			{SDL_TTF}.set_green (color, a_color.g.as_natural_8)
			{SDL_TTF}.set_blue (color, a_color.b.as_natural_8)

			if shadow then
				bg_targetarea := bg_targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
				bg_color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
				{SDL_TTF}.set_red (bg_color, 0)
				{SDL_TTF}.set_green (bg_color, 0)
				{SDL_TTF}.set_blue (bg_color, 0)
			end

			text := a_name
			size := a_size
			set_text (a_name, a_size)
			p_x := a_x
			p_y := a_y
			p_width := a_width
			p_height := a_height
			set_x ((a_width / 2) + a_x - (width / 2))
			set_y ((a_height / 2) + a_y - (height / 2))
		end

	make_empty (a_window: WINDOW; a_x, a_y: DOUBLE; a_color: TUPLE [r, g, b: INTEGER]; a_shadow: BOOLEAN)
		-- Initialize `Current' to nothing
		do
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			window := a_window
			renderer := a_window.renderer
			shadow := a_shadow
			color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
			{SDL_TTF}.set_red (color, a_color.r.as_natural_8)
			{SDL_TTF}.set_green (color, a_color.g.as_natural_8)
			{SDL_TTF}.set_blue (color, a_color.b.as_natural_8)

			if shadow then
				bg_targetarea := bg_targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
				bg_color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
				{SDL_TTF}.set_red (bg_color, 0)
				{SDL_TTF}.set_green (bg_color, 0)
				{SDL_TTF}.set_blue (bg_color, 0)
			end

			text := ""
			size := 0
			x := a_x
			y := a_y
		end

feature -- Access

	text: STRING
		-- The text to show

	size: INTEGER
		-- The size of the text (in points)

	set_text (a_text: STRING; a_size: INTEGER)
		-- Changes the displayed text to `a_text', of size `a_size'
		local
			l_c_text: C_STRING
			l_result_found: BOOLEAN
		do


			if a_text.count > 0 then
				from
					window.font.start; l_result_found := false
				until
					window.font.exhausted or l_result_found
				loop
					if window.font.item.point = a_size then
						create l_c_text.make (a_text)
						surface := {SDL_TTF}.ttf_show_text (window.font.item.font, l_c_text.item, color)

						if not surface.is_default_pointer then
						    set_width ({SDL}.get_sdl_loadbmp_width (surface))
						    set_height ({SDL}.get_sdl_loadbmp_height (surface))
							texture := {SDL}.sdl_createtexturefromsurface (renderer, surface)
						end

						if shadow then
							bg_surface := {SDL_TTF}.ttf_show_text (window.font.item.font, l_c_text.item, bg_color)

							if not bg_surface.is_default_pointer then
								{SDL}.set_sdl_rect_w (bg_targetarea, width)
								{SDL}.set_sdl_rect_h (bg_targetarea, height)
								bg_texture := {SDL}.sdl_createtexturefromsurface (renderer, bg_surface)
							end
						end

						text := a_text
						size := a_size
						l_result_found := true
					end

					window.font.forth
				end

				if not l_result_found then
				    set_width (0)
				    set_height (0)
					texture := create {POINTER}

					if shadow then
						bg_texture := create {POINTER}
					end
				end
			else
			    set_width (0)
			    set_height (0)
				texture := create {POINTER}

				if shadow then
					bg_texture := create {POINTER}
				end
			end
		end

	update
		-- Update the text on screen
		do
			if not hidden then
				if shadow then
					{SDL}.set_sdl_rect_x (bg_targetarea, (x + 1).floor)
					{SDL}.set_sdl_rect_y (bg_targetarea, (y + 1).floor)
		    		{SDL}.sdl_rendercopy (renderer, bg_texture, create {POINTER}, bg_targetarea)
		    	end

				{SDL}.set_sdl_rect_x (targetarea, x.floor)
				{SDL}.set_sdl_rect_y (targetarea, y.floor)
		    	{SDL}.sdl_rendercopy (renderer, texture, create {POINTER}, targetarea)
		    end
		end

	recenter
		-- Recenters the text inside its boundaries
		do
			set_x ((p_width / 2) + p_x - (width / 2))
			set_y ((p_height / 2) + p_y - (height / 2))
		end

feature -- Status

	shadow: BOOLEAN
		-- If true, the text will have a shadow under it

feature {NONE} -- Implementation

	p_x: DOUBLE
		-- x coordinate of the parent area

	p_y: DOUBLE
		-- y coordinate of the parent area

	p_width: DOUBLE
		-- Width of the parent area

	p_height: DOUBLE
		-- Height of the parent area

	color: POINTER
		-- Color to apply to the text

	font: POINTER
		-- Font object to apply on the text

	surface: POINTER
		-- The actual text to render

	bg_color: POINTER
		-- Color to apply to the shadow

	bg_surface: POINTER
		-- The actual shadow to render

	bg_texture: POINTER
		-- The shadow texture

	bg_targetarea: POINTER
		-- The slighlty moved area for the shadow

	dispose
		-- Free every texture, surface or rectangle used from memory
		do
			{SDL}.sdl_destroytexture (texture)
			color.memory_free
			surface.memory_free
			texture.memory_free
			targetarea.memory_free

			if shadow then
				{SDL}.sdl_destroytexture (bg_texture)
				bg_color.memory_free
				bg_surface.memory_free
				bg_texture.memory_free
				bg_targetarea.memory_free
			end
		end

end
