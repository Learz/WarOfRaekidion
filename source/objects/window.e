note
	description : "[
						War of Raekidion - A fixed window
						A {WINDOW} is a fixed, unresizable window in which 
						sprites can be rendered.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WINDOW

create
	make

feature {NONE} -- Initialization

	make (a_title: STRING; a_x, a_y, a_width, a_height: INTEGER_32; a_scale: DOUBLE; a_flags: NATURAL_32)
		-- Initialize `Current'
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
		    create l_c_title.make ("0")
		    {SDL}.sdl_sethint ({SDL}.sdl_hintrenderscalequality, l_c_title.item)
			{SDL}.sdl_rendersetlogicalsize (renderer, a_width, a_height)
			create l_c_title.make ("resources/fonts/zephyrea.ttf")
			create font.make
			font.extend ([10, {SDL_TTF}.ttf_open_font (l_c_title.item, 10)])
			font.extend ([16, {SDL_TTF}.ttf_open_font (l_c_title.item, 16)])
			font.extend ([24, {SDL_TTF}.ttf_open_font (l_c_title.item, 24)])
			font.extend ([32, {SDL_TTF}.ttf_open_font (l_c_title.item, 32)])
		end

feature -- Access

	window: POINTER
		-- The window itself

	renderer: POINTER
		-- The window's drawable surface

	height: INTEGER
		-- Height of `Current' in pixels

	width: INTEGER
		-- Width of `Current' in pixels

	scaled_height: INTEGER
		-- Scaled height of `Current'

	scaled_width: INTEGER
		-- Scaled width of `Current'

	scale: DOUBLE
		-- Scaling factor of the window

	font: LINKED_LIST [TUPLE [point: INTEGER; font: POINTER]]
		-- All fonts usable in the window

	render
		-- Render the next frame
		do
			{SDL}.sdl_renderpresent (renderer)
		end

	clear
		-- Erase the current frame
		do
			{SDL}.sdl_renderclear (renderer)
		end

	dispose
		-- Free the renderer and the window from memory
		do
			from
				font.start
			until
				font.exhausted
			loop
				font.item.font.memory_free
				font.forth
			end

		    {SDL}.sdl_destroyrenderer (renderer)
		    {SDL}.sdl_destroywindow (window)
		end

feature -- Element change

	change_size (a_scale: DOUBLE)
		-- Scale the window to `a_scale'
		do
			scaled_width := (width * a_scale).floor
			scaled_height := (height * a_scale).floor
			scale := a_scale
			{SDL}.set_sdl_window_size (window, scaled_width, scaled_height)
		end

end
