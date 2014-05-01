note
	description : "War of Raekidion - {ENTITY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENTITY

inherit
	COLLISION
	SPRITE
		rename
			make as sprite_make,
			x as sprite_x,
			y as sprite_y
		redefine
			update,
			set_x,
			set_y
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_health: DOUBLE)
		do
			starttime := {SDL}.sdl_getticks.to_integer_32
			health := a_health
		    create trajectory.make_empty
			sprite_make (a_name, a_window, a_x, a_y)
			set_x (a_x)
			set_y (a_y)
		end

feature -- Access

	x: DOUBLE
	y: DOUBLE
	health: DOUBLE
	offset: INTEGER
	trajectory: VECTOR

	update
		do
			if health <= 0 then
				destroy
			end

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

	set_x (a_x: DOUBLE)
		do
			x := a_x
		    sprite_x := a_x - width / 2
			precursor {SPRITE} (sprite_x)
		end

	set_y (a_y: DOUBLE)
		do
			y := a_y
		    sprite_y := a_y - height / 2
			precursor {SPRITE} (sprite_y)
		end

	set_health (a_health: DOUBLE)
		do
			health := a_health
		end
		
	destroy
		do
			is_destroyed := true
		end

feature {NONE} -- Implementation

	deltatime: REAL_64
	starttime, lasttime, lifetime: INTEGER

end
