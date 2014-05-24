note
	description : "[
					War of Raekidion - A 2D texturable surface
					A {SURFACE} is a simple rectangle and texture 
					definition for a sprite or any other rendered image.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

deferred class
	SURFACE

inherit
	DISPOSABLE

feature -- Access

	x: DOUBLE
		-- x coordinate of `Current'

	y: DOUBLE
		-- y coordinate of `Current'

	width: INTEGER
		-- Width of `Current' in pixels
		do
			result := {SDL}.get_sdl_rect_w (targetarea)
		end

	height: INTEGER
		-- Height of `Current' in pixels
		do
			result := {SDL}.get_sdl_rect_h (targetarea)
		end

	update
		-- Update `Current' on screen
		deferred
		end

	destroy
		-- Destroy `Current'
		do
			is_destroyed := true
		end

feature -- Status

	hidden: BOOLEAN
		-- If true, the surface will not show

	is_destroyed: BOOLEAN
		-- If true, the surface should be removed from memory

feature -- Element change

	hide
		-- Make `Current' disapear on screen
		do
			hidden := true
		end

	show
		-- Make `Current' visible on screen
		do
			hidden := false
		end

	set_x (a_x: DOUBLE)
		-- Change `x' to `a_x'
		do
			x := a_x
			{SDL}.set_sdl_rect_x (targetarea, a_x.floor)
		end

	set_y (a_y: DOUBLE)
		-- Change `y' to `a_y'
		do
			y := a_y
			{SDL}.set_sdl_rect_y (targetarea, a_y.floor)
		end

feature {NONE} -- Implementation

	window: WINDOW
		-- The window on which to display the surface

	renderer: POINTER
		-- The window's renderer

	texture: POINTER
		-- The texture made from an image

	targetarea: POINTER
		-- The rectangle containing the image

	set_width (a_width: INTEGER)
		-- Change `width' to `a_width'
		do
			{SDL}.set_sdl_rect_w (targetarea, a_width)
		end

	set_height (a_height: INTEGER)
		-- Change `height' to `a_height'
		do
			{SDL}.set_sdl_rect_h (targetarea, a_height)
		end

	dispose
		-- Free memory
		deferred
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
