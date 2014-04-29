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

	make (a_title: STRING; a_x, a_y, a_width, a_height: INTEGER_32; a_scale: DOUBLE; a_flags: NATURAL_32)
		local
			l_c_title: C_STRING
		do
			create l_c_title.make (a_title)
		    width := a_width
		    height := a_height
		    scale := a_scale
		    scaled_width := (width * scale).floor
		    scaled_height := (height * scale).floor
		    window := {SDL}.sdl_createwindow (l_c_title.item, a_x, a_y, scaled_width, scaled_height, a_flags)
		    renderer := {SDL}.sdl_createrenderer (window, -1, {SDL}.sdl_renderer_accelerated)
		    {SDL}.sdl_sethint ({SDL}.sdl_hintrenderscalequality, 0)
			{SDL}.sdl_rendersetlogicalsize (renderer, a_width, a_height)
			create l_c_title.make ("resources/fonts/zephyrea.ttf")
			create font.make
			font.extend ([10, {SDL_TTF}.ttf_open_font (l_c_title.item, 10)])
			font.extend ([16, {SDL_TTF}.ttf_open_font (l_c_title.item, 16)])
			font.extend ([24, {SDL_TTF}.ttf_open_font (l_c_title.item, 24)])
			font.extend ([32, {SDL_TTF}.ttf_open_font (l_c_title.item, 32)])
		end

feature -- Access

	window, renderer: POINTER
	height, width, scaled_height, scaled_width: INTEGER
	scale: DOUBLE
	font: LINKED_LIST [TUPLE [point: INTEGER; font: POINTER]]

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

feature -- Element change

	change_size (a_scale: DOUBLE)
		do
			scaled_width := (width * a_scale).floor
			scaled_height := (height * a_scale).floor
			scale := a_scale
			{SDL}.set_sdl_window_size (window, scaled_width, scaled_height)
		end

end
