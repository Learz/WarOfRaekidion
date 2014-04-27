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

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_dest_x, a_dest_y: DOUBLE; a_id: INTEGER)
		do
			enemyfactory := enemy_factory
			enemy_properties := enemyfactory.enemy (a_name)
			ship_make (enemy_properties.filename, a_window, a_x, a_y, enemy_properties.health)
			dest_x := a_dest_x
			dest_y := a_dest_y
			id := a_id
			create random.make
		ensure
			enemy_properties_not_null: enemy_properties.name /= ""
		end

feature -- Access

	id: INTEGER
	enemy_properties: ENEMY_PROPERTIES

	update (a_x, a_y: DOUBLE)
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
						l_random_int := (random.double_item * enemy_properties.spread).floor - (enemy_properties.spread / 2).floor
						random.forth
						create l_vector.make_from_x_y (a_x - x, -a_y + y)
						l_vector.enable_degree_mode
						on_shoot.call ([enemy_properties.bullet, x.floor, y.floor, l_vector.angle + l_random_int, id])
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
	dest_x, dest_y: DOUBLE
	enemyfactory: ENEMY_FACTORY
	create_projectile: BOOLEAN

end
