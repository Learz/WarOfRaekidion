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
			make as sprite_make
		redefine
			update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_health: NATURAL_16)
		do
			type := "entity"
			starttime := {SDL_WRAPPER}.sdl_getticks.to_integer_32
			health := a_health
		    create on_collision
		    create on_creation
		    create trajectory.make_empty
			sprite_make (a_name, a_window, a_x, a_y)
		    x := x - width / 2
		    y := y - height / 2
		end

feature -- Access

	health: NATURAL_16
	type: STRING
	trajectory: VECTOR
	on_collision: ACTION_SEQUENCE [TUPLE [a_other: ENTITY]]
	on_creation: ACTION_SEQUENCE [TUPLE [a_entity: ENTITY]]

	update
		do
			if health <= 0 then
				destroy
			end

			on_collision.call (current)
			lifetime := lifetime + 1
			deltatime := lifetime - lasttime
			lasttime := lifetime
			set_x (x + (trajectory.x))
			set_y (y - (trajectory.y))
			precursor {SPRITE}
		end

	manage_collision (a_other: ENTITY)
		do
			if collide_entity (current, a_other, a_other.collision_offset) then
				a_other.set_health (a_other.health - 1)
			end
		end

feature -- Status

	is_destroyed: BOOLEAN

feature -- Element change

	set_health (a_health: NATURAL_16)
		do
			health := a_health
		end

	destroy
		do
			on_creation.wipe_out
			on_collision.wipe_out
			is_destroyed := true
		end

feature {NONE} -- Implementation

	deltatime: REAL_64
	starttime, lasttime, lifetime: INTEGER

end
