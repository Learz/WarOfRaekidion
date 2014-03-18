note
	description : "War of Raekidion - {PLAYER_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PLAYER_SHIP

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

	make(a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			ship_make ("player", a_window, a_x, a_y)
		end

feature

	update
		local
			l_projectile: PROJECTILE
		do
			if create_projectile then
				projectile_delay := (projectile_delay + 1) \\ 20

				if projectile_delay = 0 then
					l_projectile := create {PROJECTILE}.make ("laser", window, x + (width / 2).floor - 4, y - 4)
					l_projectile.trajectory.set_to_degrees
					l_projectile.trajectory.define_position_from_angle_force (90, 4)
					projectile_list.extend (l_projectile)
				end
			end

			ship_update
		end

	start_shooting
		do
			create_projectile := true
		end

	stop_shooting
		do
			create_projectile := false
		end

end
