note
	description	: "[
					War of Raekidion - An enemy ship
					An {ENEMY_SHIP} is an entity who's only goal is 
					to shoot at the player.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	ENEMY_SHIP

inherit
	ENEMY_FACTORY_SHARED
	SHIP
		rename
			make as ship_make,
			update as ship_update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_dest_x, a_dest_y: DOUBLE)
		-- Initialize `Current' from `a_name', `a_window', `a_x', `a_y', `a_dest_x' and `a_dest_y'
		do
			enemyfactory := enemy_factory
			enemy_properties := enemyfactory.enemy (a_name)
			ship_make (enemy_properties.filename, a_window, a_x, a_y, enemy_properties.health, 1)
			dest_x := a_dest_x
			dest_y := a_dest_y
			create random.make
		ensure
			enemy_properties_not_null: enemy_properties.name /= ""
				-- Ensure the enemy type exists
		end

feature -- Access

	enemy_properties: ENEMY_PROPERTIES
		-- The enemy type the enemy will copy

	update (a_x, a_y: DOUBLE)
		-- Update the enemy on screen from player's `a_x' and `a_y'
		local
			l_vector: VECTOR
			l_random_int: INTEGER
			l_count: INTEGER
		do
			if (dest_x - x) <= 5 and (dest_y - y) <= 5 then
				trajectory.set_force (0)

				if lifetime \\ enemy_properties.firerate = 0 then
					from
						l_count := 0
					until
						l_count = enemy_properties.count
					loop
						if enemy_properties.aiming then
							l_random_int := (random.double_item * enemy_properties.spread).floor - (enemy_properties.spread / 2).floor
							random.forth
							create l_vector.make_from_x_y (a_x - x, -a_y + y)
							l_vector.enable_degree_mode
							on_shoot.call ([enemy_properties.bullet, x.floor, y.floor, l_vector.angle + l_random_int, Current])
						else
							on_shoot.call ([enemy_properties.bullet, x.floor, y.floor, lifetime * enemy_properties.spread, Current])
						end

						l_count := l_count + 1
					end
				end
			else
				trajectory.set_x_and_y (dest_x - x, -dest_y + y)
				trajectory.set_force (enemy_properties.speed)
			end

			ship_update
		end

feature {NONE} -- Implementation

	random: RANDOM
		-- The random number generator

	dest_x: DOUBLE
		-- The x coordinate the enemy is aiming to reach

	dest_y: DOUBLE
		-- The y coordinate the enemy is aiming to reach

	enemyfactory: ENEMY_FACTORY
		-- The factory containing the enemy types

	create_projectile: BOOLEAN
		-- True if the enemy is ready to shoot

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
