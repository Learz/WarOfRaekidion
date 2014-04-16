note
	description: "Summary description for {TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
		do
			window := a_window
			renderer := a_window.renderer
			shadow := a_shadow
			color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
			{SDL_TTF}.set_red (color, a_color.r.as_natural_8)
			{SDL_TTF}.set_green (color, a_color.g.as_natural_8)
			{SDL_TTF}.set_blue (color, a_color.b.as_natural_8)

			if shadow then
				bg_color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
				{SDL_TTF}.set_red (bg_color, 0)
				{SDL_TTF}.set_green (bg_color, 0)
				{SDL_TTF}.set_blue (bg_color, 0)
			end

			set_text (a_name, a_size)
			set_x (a_x)
			set_y (a_y)
		end

	make_centered (a_name: STRING; a_size: INTEGER; a_window: WINDOW; a_x, a_y, a_width, a_height: DOUBLE; a_color: TUPLE [r, g, b: INTEGER]; a_shadow: BOOLEAN)
		do
			window := a_window
			renderer := a_window.renderer
			shadow := a_shadow
			color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
			{SDL_TTF}.set_red (color, a_color.r.as_natural_8)
			{SDL_TTF}.set_green (color, a_color.g.as_natural_8)
			{SDL_TTF}.set_blue (color, a_color.b.as_natural_8)

			if shadow then
				bg_color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
				{SDL_TTF}.set_red (bg_color, 0)
				{SDL_TTF}.set_green (bg_color, 0)
				{SDL_TTF}.set_blue (bg_color, 0)
			end

			set_text (a_name, a_size)
			set_x ((a_width / 2) + a_x - (width / 2))
			set_y ((a_height / 2) + a_y - (height / 2))
		end

	make_empty (a_window: WINDOW; a_x, a_y: DOUBLE; a_color: TUPLE [r, g, b: INTEGER]; a_shadow: BOOLEAN)
		do
			window := a_window
			renderer := a_window.renderer
			shadow := a_shadow
			color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
			{SDL_TTF}.set_red (color, a_color.r.as_natural_8)
			{SDL_TTF}.set_green (color, a_color.g.as_natural_8)
			{SDL_TTF}.set_blue (color, a_color.b.as_natural_8)

			if shadow then
				bg_color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
				{SDL_TTF}.set_red (bg_color, 0)
				{SDL_TTF}.set_green (bg_color, 0)
				{SDL_TTF}.set_blue (bg_color, 0)
			end

			x := a_x
			y := a_y
		end

feature -- Access

	set_text (a_text: STRING; a_size: INTEGER)
		local
			l_c_text: C_STRING
			l_result_found: BOOLEAN
		do
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)

			if shadow then
				bg_targetarea := bg_targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			end

			if a_text.count > 0 then
				from
					window.font.start; l_result_found := false
				until
					window.font.exhausted or l_result_found
				loop
					if window.font.item.point = a_size then
						create l_c_text.make (a_text)
						surface := {SDL_TTF}.ttf_show_text (window.font.item.font, l_c_text.item, color)
					    set_width ({SDL}.get_sdl_loadbmp_width (surface))
					    set_height ({SDL}.get_sdl_loadbmp_height (surface))
						texture := {SDL}.sdl_createtexturefromsurface (renderer, surface)

						if shadow then
							bg_surface := {SDL_TTF}.ttf_show_text (window.font.item.font, l_c_text.item, bg_color)
							{SDL}.set_sdl_rect_w (bg_targetarea, width)
							{SDL}.set_sdl_rect_h (bg_targetarea, height)
							bg_texture := {SDL}.sdl_createtexturefromsurface (renderer, bg_surface)
						end

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
		do
			if not hidden then
				if shadow then
					{SDL}.set_sdl_rect_x (bg_targetarea, (x + 1).floor)
					{SDL}.set_sdl_rect_y (bg_targetarea, (y + 1).floor)
		    		{SDL}.sdl_rendercopy (renderer, bg_texture, create {POINTER}, bg_targetarea)
		    	end

		    	{SDL}.sdl_rendercopy (renderer, texture, create {POINTER}, targetarea)
		    end
		end

feature -- Status

	shadow: BOOLEAN

feature {NONE} -- Implementation

	color, bg_color, surface, bg_surface, bg_texture, font, bg_targetarea: POINTER

	dispose
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
