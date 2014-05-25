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
		local
			l_ticks, l_deltatime, l_alpha: INTEGER
		do
			window := a_window
			surface := image_factory.image (a_name)

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
				l_alpha > 250
			loop
				l_ticks := {SDL}.sdl_getticks.to_integer_32
				window.clear

				if l_alpha < 50 and l_alpha <= 100 then
					{SDL}.sdl_settexturealphamod (texture, ((l_alpha / 50) * 255).floor.as_natural_8)
				elseif l_alpha > 150 and l_alpha <= 200 then
					{SDL}.sdl_settexturealphamod (texture, (((200 - l_alpha) / 50) * 255).floor.as_natural_8)
				elseif l_alpha > 100 and l_alpha <= 150 then
					{SDL}.sdl_setrenderdrawcolor (window.renderer, 255, 255, 255, 255)
					{SDL}.sdl_settexturealphamod (texture, 255)
				end

				{SDL}.sdl_rendercopy (window.renderer, texture, create {POINTER}, targetarea)
				window.render
				l_alpha := l_alpha + 1
				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end
		end

feature {NONE} -- Implementation

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
