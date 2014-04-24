note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

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
		do
			enemyfactory := enemy_factory
			enemy_properties := enemyfactory.enemy (a_name)
			ship_make (enemy_properties.filename, a_window, a_x, a_y, enemy_properties.health)
			dest_x := a_dest_x
			dest_y := a_dest_y
		ensure
			enemy_properties_not_null: enemy_properties.name /= ""
		end

feature -- Access

	update (a_x, a_y: DOUBLE)
		local
			l_projectile: PROJECTILE
			l_random: RANDOM
			l_random_int: INTEGER
			l_count: INTEGER
			l_force: DOUBLE
		do
			if lifetime \\ enemy_properties.firerate = 0 then
				create l_random.make

				from
					l_count := 0
				until
					l_count = enemy_properties.count
				loop
					l_random_int := (l_random.double_item * enemy_properties.spread).floor - (enemy_properties.spread / 2).floor
					l_random.forth
					create l_projectile.make (enemy_properties.bullet, window, x + (width / 2).floor, y + (height / 2).floor, 0, false)
					l_projectile.trajectory.set_x_and_y (a_x - x, -a_y + y)
					l_projectile.trajectory.set_angle (l_projectile.trajectory.angle + l_random_int)
					l_projectile.trajectory.set_force (l_projectile.projectile_properties.speed)
					on_shoot.call (l_projectile)
					l_count := l_count + 1
				end
			end

			if not (dest_x - x = 0 and dest_y - y = 0) then
				l_force := trajectory.force
				trajectory.set_x_and_y (dest_x - x, -dest_y - y)

				if (dest_x ^ 2 + dest_y ^ 2) - (x ^ 2 + y ^ 2) < 10 then
					trajectory.set_force (l_force * 0.95)
				else
					trajectory.set_force (enemy_properties.speed)
				end
			else
				trajectory.set_force (0)
			end

			ship_update
		end

feature {NONE} -- Implementation

	dest_x, dest_y: DOUBLE
	enemyfactory: ENEMY_FACTORY
	enemy_properties: ENEMY_PROPERTIES
	create_projectile: BOOLEAN

end
