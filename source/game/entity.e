note
	description	: "[
					War of Raekidion - An entity
					An {ENTITY} is a sprite with advanced management properties
					allowing more accurate movement along a vector and lifetime handling.
				]"
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

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_health: DOUBLE)
		-- Initialize `Current' from `a_name', `a_window', `a_x', `a_y' and `a_health'
		do
			lifetime := 0
			health := a_health
		    create trajectory.make_empty
			sprite_make (a_name, a_window, a_x, a_y)
			set_x (a_x)
			set_y (a_y)
		end

feature -- Access

	x: DOUBLE
		-- x coordinate of `Current'

	y: DOUBLE
		-- y coordinate of `Current'

	health: DOUBLE
		-- Health of `Current'

	offset: INTEGER
		-- Collision offset

	trajectory: VECTOR
		-- Direction which `Current' will go to

	update
		-- Update `Current' on screen
		do
			if health <= 0 then
				destroy
			end

			lifetime := lifetime + 1
			set_x (x + (trajectory.x))
			set_y (y - (trajectory.y))
			precursor {SPRITE}
		end

feature -- Element change

	set_x (a_x: DOUBLE)
		-- Assign `x' to `a_x'
		do
			x := a_x
		    sprite_x := a_x - width / 2
			precursor {SPRITE} (sprite_x)
		end

	set_y (a_y: DOUBLE)
		-- Assign `y' to `a_y'
		do
			y := a_y
		    sprite_y := a_y - height / 2
			precursor {SPRITE} (sprite_y)
		end

	set_health (a_health: DOUBLE)
		-- Assign `health' to `a_health'
		do
			health := a_health
		end

feature {NONE} -- Implementation

	lifetime: INTEGER
		-- The time which the entity has lived

end
