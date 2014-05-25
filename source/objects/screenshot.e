note
	description : "[
					War of Raekidion - A screen capture
					A {SCREENSHOT} is an image taken from the current window, 
					taking its size and containing every element at the taken frame.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	SCREENSHOT

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW)
		-- Initialize `Current' from `a_window'
		do
			window := a_window
			surface := {SDL}.sdl_creatergbsurface (0, window.scaled_width, window.scaled_height, 32, 0x00ff0000, 0x0000ff00, 0x000000ff, 0xff000000)

			if not surface.is_default_pointer then
				targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
				{SDL}.set_sdl_rect_x (targetarea, 0)
				{SDL}.set_sdl_rect_y (targetarea, 0)
			    {SDL}.set_sdl_rect_w (targetarea, window.width)
			    {SDL}.set_sdl_rect_h (targetarea, window.height)
			    {SDL}.sdl_renderreadpixels (window.renderer, create {POINTER}, {SDL}.SDL_PIXELFORMAT_ARGB8888, {SDL}.get_sdl_surface_pixels (surface), {SDL}.get_sdl_surface_pitch (surface));
				texture := {SDL}.sdl_createtexturefromsurface (window.renderer, surface)
			end
		end

feature -- Access

	save (a_filename: STRING)
		-- Save `Current' under `a_filename'
		local
			l_c_string: C_STRING
		do
			create l_c_string.make (a_filename)
			{SDL}.sdl_savebmp (surface, l_c_string.item)
		end

	update
		-- Update `Current'
		do
			{SDL}.sdl_rendercopy (window.renderer, texture, create {POINTER}, targetarea)
		end

feature {NONE} -- Implementation

	window: WINDOW
		-- The window from which to take the capture

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
