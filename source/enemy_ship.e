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
			make as ship_make
		redefine
			update
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
				l_projectile := create {PROJECTILE}.make ("bullet_red", window, x + (width / 2).floor - 8, y + (height / 2).floor - 8)
				l_projectile.trajectory.enable_degree_mode
				l_projectile.trajectory.set_angle (lifetime * 3)
				l_projectile.trajectory.set_force (0.2)
				projectile_list.extend (l_projectile)
			end

			Precursor {SHIP}
		end

end
