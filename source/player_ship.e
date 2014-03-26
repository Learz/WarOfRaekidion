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
	KEYS

create
	make

feature {NONE} -- Initialization

	speed: DOUBLE
	shoot: BOOLEAN
	projectile_delay: INTEGER

	make(a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			ship_make ("player", a_window, a_x, a_y)
		    trajectory.set_degree
			speed := 1
		end

feature

	update
		local
			l_projectile: PROJECTILE
		do
			if shoot then
				projectile_delay := (projectile_delay + 1) \\ 20

				if projectile_delay = 0 then
					l_projectile := create {PROJECTILE}.make ("laser", window, x + (width / 2).floor - 4, y - 4)
					l_projectile.trajectory.set_degree
					l_projectile.trajectory.set_angle (90)
					l_projectile.trajectory.set_force (4)
					projectile_list.extend (l_projectile)
				end
			end

			ship_update
		end

	manage_key (a_key: INTEGER; a_state: BOOLEAN)
		do
			if a_state = true then
				if a_key = move_up_key then
					trajectory.set_y (speed)
				elseif a_key = move_down_key then
					trajectory.set_y (-speed)
				elseif a_key = move_left_key then
					trajectory.set_x (-speed)
				elseif a_key = move_right_key then
					trajectory.set_x (speed)
				elseif a_key = accept_key then
					shoot := true
				elseif a_key = modifier_key then
					speed := 0.3
				end
			else
				if a_key = move_up_key and trajectory.y >= 0 then
					trajectory.set_y (0)
				elseif a_key = move_down_key and trajectory.y <= 0 then
					trajectory.set_y (0)
				elseif a_key = move_left_key and trajectory.x <= 0 then
					trajectory.set_x (0)
				elseif a_key = move_right_key and trajectory.x >= 0 then
					trajectory.set_x (0)
				elseif a_key = accept_key then
					shoot := false
				elseif a_key = modifier_key then
					speed := 0.8
				end
			end
		end

end
