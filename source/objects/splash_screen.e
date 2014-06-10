note
	description : "[
					War of Raekidion - A logo screen
					A {SPLASH_SCREEN} is a logo shown on the screen 
					before getting to the actual game.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	SPLASH_SCREEN

inherit
	DISPOSABLE
	IMAGE_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW)
		-- Initialize `Current' from `a_name' and `a_window'
		do
			window := a_window
			surface := image_factory.image (a_name)
			loading_message := "Loading ..."
			loading_text := create {TEXT}.make_centered (loading_message, 16, window, 0, 350, window.width, 50, [0, 0, 0], false)
			create debug_file.make_create_read_write ("resources.log")
			debug_file.flush
		end

feature -- Access

	display_splash
		-- Display the splash screen
		local
			l_ticks, l_deltatime, l_alpha: INTEGER
		do
			if not surface.is_default_pointer then
				targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
				{SDL}.set_sdl_rect_x (targetarea, 0)
				{SDL}.set_sdl_rect_y (targetarea, 0)
			    {SDL}.set_sdl_rect_w (targetarea, window.width)
			    {SDL}.set_sdl_rect_h (targetarea, window.height)
				texture := {SDL}.sdl_createtexturefromsurface (window.renderer, surface)
			end

			from
			until
				l_alpha > 120
			loop
				l_ticks := {SDL}.sdl_getticks.to_integer_32
				window.clear

				if l_alpha <= 50 then
					{SDL}.sdl_settexturealphamod (texture, ((l_alpha / 50) * 255).floor.as_natural_8)
				elseif l_alpha > 75 and l_alpha <= 100 then
					{SDL}.sdl_settexturealphamod (texture, (((75 - l_alpha) / 25) * 255).floor.as_natural_8)
				elseif l_alpha > 50 and l_alpha <= 75 then
					{SDL}.sdl_setrenderdrawcolor (window.renderer, 255, 255, 255, 255)
					{SDL}.sdl_settexturealphamod (texture, 255)
				end

				{SDL}.sdl_rendercopy (window.renderer, texture, create {POINTER}, targetarea)
				loading_text.set_text (loading_message, loading_text.size)
            	loading_text.recenter
				loading_text.update
				window.render
				l_alpha := l_alpha + 1
				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end
			
			debug_file.close
		end

	write_debug_file (a_message: STRING)
		do
			debug_file.put_string (a_message)
			debug_file.put_new_line
		end

feature -- Element change

	change_message (a_message: STRING)
		do
			loading_message := a_message
		end

feature {NONE} -- Implementation

	debug_file: PLAIN_TEXT_FILE

	loading_message: STRING

	loading_text: TEXT

	window: WINDOW
		-- The window in which to draw the screen

	targetarea: POINTER
		-- The rectangle containing the image

	surface: POINTER
		-- The surface to convert into an image

	texture: POINTER
		-- The image itself

	dispose
		-- Remove `Current' from memory
		do
			{SDL}.sdl_freesurface (surface)
			{SDL}.sdl_destroytexture (texture)
			targetarea.memory_free
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
