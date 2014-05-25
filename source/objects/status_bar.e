note
	description: "Summary description for {STATUS_BAR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STATUS_BAR

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_x, a_y, a_width, a_height: INTEGER; a_color: TUPLE [r, g, b, a: INTEGER]; a_vertical: BOOLEAN)
		-- Initialize `Current' from `a_window', `a_x', `a_y', `a_width', `a_height', `a_scale', `a_color' and `a_vertical'
		do
			window := a_window
			max_width := a_width
			max_height := a_height
			red := a_color.r
			green := a_color.g
			blue := a_color.b
			alpha := a_color.a
			vertical := a_vertical
			targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
			{SDL}.set_sdl_rect_x (targetarea, a_x)
			{SDL}.set_sdl_rect_y (targetarea, a_y)
		    {SDL}.set_sdl_rect_w (targetarea, a_width)
		    {SDL}.set_sdl_rect_h (targetarea, a_height)
		end

feature -- Access

	value: INTEGER assign set_value
		-- The current value in percents

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
		-- Update `Current'
		do
			if vertical then
				set_height ((value * (max_height / 100)).floor)
			else
				set_width ((value * (max_width / 100)).floor)
			end

			{SDL}.sdl_getrenderdrawcolor (window.renderer, $old_red, $old_green, $old_blue, $old_alpha)
			{SDL}.sdl_setrenderdrawcolor (window.renderer, red.as_natural_8, green.as_natural_8, blue.as_natural_8, alpha.as_natural_8)
			{SDL}.sdl_renderfillrect (window.renderer, targetarea)
			{SDL}.sdl_setrenderdrawcolor (window.renderer, old_red.as_natural_8, old_green.as_natural_8, old_blue.as_natural_8, old_alpha.as_natural_8)
		end

feature -- Status

	vertical: BOOLEAN
		-- True if the status bar is vertical

feature -- Element change

	set_value (a_value: INTEGER)
		-- Sets the status bar value to `a_value' across `scale'
		do
			if a_value < 0 then
				value := 0
			elseif a_value > 100 then
				value :=100
			else
				value := a_value
			end
		end

feature {NONE} -- Implementation

	red: INTEGER
		-- Red value of `Current'

	green: INTEGER
		-- Green value of `Current'

	blue: INTEGER
		-- Blue value of `Current'

	alpha: INTEGER
		-- Alpha value of `Current'

	old_red: INTEGER
		-- Default red value of the renderer

	old_green: INTEGER
		-- Default green value of the renderer

	old_blue: INTEGER
		-- Default blue value of the renderer

	old_alpha: INTEGER
		-- Default alpha value of the renderer

	window: WINDOW
		-- The window in which to draw the screen

	targetarea: POINTER
		-- The rectangle containing the image

	max_width: INTEGER
		-- The actual width of the container

	max_height: INTEGER
		-- The actual height of the container

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
		-- Remove `Current' from memory
		do
			targetarea.memory_free
		end

invariant
	valid_value: value <= 100 and value >= 0
		-- The status bar value must remain within limits

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
