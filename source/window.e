note
	description : "War of Raekidion - {WINDOW} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	WINDOW

create
	make

feature {NONE} -- Initialization

	make (a_title: STRING; a_x, a_y, a_width, a_height: INTEGER_32; a_flags: NATURAL_32)
		local
			l_c_title: C_STRING
		do
			create l_c_title.make (a_title)
		    height := a_height
		    width := a_width
		    window := {SDL_WRAPPER}.sdl_createwindow (l_c_title.item, a_x, a_y, width, height, a_flags)
		    renderer := {SDL_WRAPPER}.sdl_createrenderer (window, -1, {SDL_WRAPPER}.sdl_renderer_accelerated)
		end

feature -- Access

	window, renderer: POINTER
	height, width: INTEGER

	render
		do
			{SDL_WRAPPER}.sdl_renderpresent (renderer)
			if {SDL_WRAPPER}.sdl_getwindowflags (window).bit_and ({SDL_WRAPPER}.sdl_window_hidden) /= 0 then
		   		{SDL_WRAPPER}.sdl_show_window (window)
			end
		end

	clear
		do
			{SDL_WRAPPER}.sdl_renderclear (renderer)
		end

	dispose
		do
		    {SDL_WRAPPER}.sdl_destroyrenderer (renderer)
		    {SDL_WRAPPER}.sdl_destroywindow (window)
		end

end
