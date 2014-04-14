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

	width, height: INTEGER_16
	x, y: DOUBLE

	update
		deferred
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

	dispose
		deferred
		end

end
