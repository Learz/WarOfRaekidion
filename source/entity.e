note
	description : "War of Raekidion - {ENTITY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENTITY

inherit
	SPRITE
		rename
			make as sprite_make,
			update as sprite_update
		end

create
	make

feature {NONE} -- Initialization

	deltatime: REAL_64
	starttime, lasttime, lifetime: INTEGER

	make(a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		--Créer l'entitée
		do
			starttime := {SDL_WRAPPER}.sdl_getticks.to_integer_32
		    create trajectory.make_default
			sprite_make (a_name, a_window, a_x, a_y)
		end

	update
		do
			lifetime := lifetime + 1
			deltatime := lifetime - lasttime
			lasttime := lifetime
			set_x (x + trajectory.position.x)
			set_y (y - trajectory.position.y)
			sprite_update
		end

feature -- Access

	trajectory: VECTOR

end
