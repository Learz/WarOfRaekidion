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
		    window := {SDL}.sdl_createwindow (l_c_title.item, a_x, a_y, width * 2, height * 2, a_flags)
		    renderer := {SDL}.sdl_createrenderer (window, -1, {SDL}.sdl_renderer_accelerated)
		    {SDL}.sdl_sethint ({SDL}.sdl_hintrenderscalequality, 0)
			{SDL}.sdl_rendersetlogicalsize (renderer, a_width, a_height)
			--create l_c_title.make ("resources/fonts/zephyrea.ttf")
			--font := {SDL_TTF}.ttf_open_font (l_c_title.item, 32)
		end

feature -- Access

	window, renderer, font: POINTER
	height, width: INTEGER

	render
		do
			{SDL}.sdl_renderpresent (renderer)
		end

	clear
		do
			{SDL}.sdl_renderclear (renderer)
		end

	dispose
		do
		    {SDL}.sdl_destroyrenderer (renderer)
		    {SDL}.sdl_destroywindow (window)
		end

end
