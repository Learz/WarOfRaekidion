note
	description	: "[
					War of Raekidion - An entity
					An {ENTITY} is a sprite with advanced management properties
					allowing more accurate movement along a vector and lifetime handling.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

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

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_health: DOUBLE; a_lives: INTEGER)
		-- Initialize `Current' from `a_name', `a_window', `a_x', `a_y', `a_health' and `a_lives'
		do
			lifetime := 0
			max_health := a_health
			health := a_health
			lives := a_lives
		    create trajectory.make_empty
			sprite_make (a_name, a_window, a_x, a_y)
			set_x (a_x)
			set_y (a_y)
		end

feature -- Access

	x: DOUBLE assign set_x
		-- x coordinate of `Current'

	y: DOUBLE assign set_y
		-- y coordinate of `Current'

	health: DOUBLE assign set_health
		-- Health of `Current'

	max_health: DOUBLE
		-- Maximum health of `Current'

	lives: INTEGER assign set_lives
		-- The number of times `Current' can respawn after it "dies"

	offset: INTEGER
		-- Collision offset of `Current'

	trajectory: VECTOR
		-- Direction which `Current' will go to

	lifetime: INTEGER
		-- The time which `Current' has lived

	update
		-- Update `Current' on screen
		do
			if health <= 1 then
				if lives <= 1 then
					destroy
				end

				lives := lives - 1
				health := max_health
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
			if a_health > max_health then
				health := max_health
			elseif a_health < 0 then
				health := 0
			else
				health := a_health
			end
		end

	set_lives (a_lives: INTEGER)
		-- Assign `lives' to `a_lives'
		do
			lives := a_lives
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
