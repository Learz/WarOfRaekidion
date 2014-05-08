note
	description: "Summary description for {EXPLOSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXPLOSION

inherit
	ANIMATION
		rename
			x as animation_x,
			y as animation_y
		redefine
			set_x,
			set_y
		end

create
	make

feature -- Access

	x: DOUBLE
		-- x coordinate of `Current'

	y: DOUBLE
		-- y coordinate of `Current'

feature -- Element change

	set_x (a_x: DOUBLE)
		-- Change `x' to `a_x'
		do
			x := a_x
			animation_x := a_x - (width / 2)
			{SDL}.set_sdl_rect_x (sizearea, animation_x.floor)
			{SDL}.set_sdl_rect_x (targetarea, width * current_frame)
		end

	set_y (a_y: DOUBLE)
		-- Change `y' to `a_y'
		do
			y := a_y
			animation_y := a_y - (height / 2)
			{SDL}.set_sdl_rect_y (sizearea, animation_y.floor)
			{SDL}.set_sdl_rect_x (targetarea, 0)
		end
		
end
