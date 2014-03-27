note
	description : "War of Raekidion - {ENTITY} class"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENTITY

inherit
	SPRITE
		rename
			make as sprite_make
		redefine
			update
		end

create
	make

feature {NONE} -- Initialization

	deltatime: REAL_64
	starttime, lasttime, lifetime: INTEGER

	make(a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		--Cr�er l'entit�e
		do
			starttime := {SDL_WRAPPER}.sdl_getticks.to_integer_32
		    create trajectory.default_create
			sprite_make (a_name, a_window, a_x, a_y)
		end

	update
		do
			lifetime := lifetime + 1
			deltatime := lifetime - lasttime
			lasttime := lifetime
			set_x (x + (trajectory.x))
			set_y (y - (trajectory.y))
			Precursor {SPRITE}
		end

feature -- Access

	trajectory: VECTOR

end
