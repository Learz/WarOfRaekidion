note
	description : "War of Raekidion - {ENTITY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENTITY

inherit
	SPRITE
		redefine
			make,
			update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			starttime := {SDL_WRAPPER}.sdl_getticks.to_integer_32
		    create trajectory.make_empty
			precursor {SPRITE} (a_name, a_window, a_x, a_y)
		    x := x - width / 2
		    y := y - height / 2
		end

feature -- Access

	trajectory: VECTOR

	update
		do
			lifetime := lifetime + 1
			deltatime := lifetime - lasttime
			lasttime := lifetime

			set_x (x + (trajectory.x))
			set_y (y - (trajectory.y))

			precursor {SPRITE}
		end

feature -- Status

	is_destroyed: BOOLEAN

feature -- Element change

	destroy
		do
			is_destroyed := true
		end

feature {NONE} -- Implementation

	deltatime: REAL_64
	starttime, lasttime, lifetime: INTEGER

end
