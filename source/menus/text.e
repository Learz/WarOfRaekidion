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
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_size: INTEGER; a_window: WINDOW; a_x, a_y: DOUBLE)
		local
			l_c_name: C_STRING
		do
			window := a_window
			create l_c_name.make (a_name)
			renderer := a_window.renderer
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			color := color.memory_alloc ({SDL_TTF}.sizeof_sdl_color_struct)
			{SDL_TTF}.set_red (color, 255)
			{SDL_TTF}.set_green (color, 255)
			{SDL_TTF}.set_blue (color, 255)
			{SDL_TTF}.set_alpha (color, 255)
			surface := {SDL_TTF}.ttf_show_text (a_window.font, l_c_name.item, color)
		    width := {SDL}.get_sdl_loadbmp_width (surface).as_integer_16
		    height := {SDL}.get_sdl_loadbmp_height (surface).as_integer_16
		    {SDL}.set_sdl_rect_w (targetarea, width)
		    {SDL}.set_sdl_rect_h (targetarea, height)
			set_x (a_x)
			set_y (a_y)
			texture := {SDL}.sdl_createtexturefromsurface (renderer, surface)
		end

feature -- Access

	set_text (a_text: STRING)
		do

		end

	update
		do
		    {SDL}.sdl_rendercopy (renderer, texture, create {POINTER}, targetarea)
		end

feature {NONE} -- Implementation

	color, surface: POINTER

	dispose
		do
			{SDL}.sdl_destroytexture (texture)
			color.memory_free
			texture.memory_free
			targetarea.memory_free
		end

end
