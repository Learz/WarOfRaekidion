note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENEMY_SHIP

inherit
	SHIP
		rename
			make as ship_make,
			update as ship_update
		end

create
	make

feature {NONE} -- Initialization

	create_projectile: BOOLEAN
	projectile_delay: INTEGER

	make(a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			ship_make (a_name, a_window, a_x, a_y)
		end

feature

	update
		local
			l_projectile: PROJECTILE
		do
			projectile_delay := (projectile_delay + 1) \\ 20

			if projectile_delay = 0 then
				l_projectile := create {PROJECTILE}.make ("sbullet", window, x + (width / 2).floor - 8, y + (height / 2).floor - 8)
				l_projectile.trajectory.set_degree
				l_projectile.trajectory.set_angle (lifetime * 8.1)
				l_projectile.trajectory.set_force (0.2)
				projectile_list.extend (l_projectile)
			end

			ship_update
		end

end
