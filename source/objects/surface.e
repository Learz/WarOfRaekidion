note
	description: "Summary description for {SURFACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SURFACE

inherit
	DISPOSABLE

feature -- Access

	x, y: DOUBLE

	width: INTEGER
		do
			result := {SDL}.get_sdl_rect_w (targetarea)
		end

	height: INTEGER
		do
			result := {SDL}.get_sdl_rect_h (targetarea)
		end

	update
		deferred
		end

feature -- Status

	hidden: BOOLEAN
	
feature -- Element change

	hide
		do
			hidden := true
		end

	show
		do
			hidden := false
		end

	set_x (a_x: DOUBLE)
		do
			x := a_x
			{SDL}.set_sdl_rect_x (targetarea, a_x.floor)
		end

	set_y (a_y: DOUBLE)
		do
			y := a_y
			{SDL}.set_sdl_rect_y (targetarea, a_y.floor)
		end

feature {NONE} -- Implementation

	window: WINDOW
	renderer, texture, targetarea: POINTER

	set_width (a_width: INTEGER)
		do
			--width := a_width
			{SDL}.set_sdl_rect_w (targetarea, a_width)
		end

	set_height (a_height: INTEGER)
		do
			--height := a_height
			{SDL}.set_sdl_rect_h (targetarea, a_height)
		end

	dispose
		deferred
		end

end
