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
			make as ship_make
		redefine
			update,
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_x, a_y: DOUBLE; a_key_binding: KEYS)
		do
			ship_make ("player", a_window, a_x, a_y, 500)
			type := type + ".player"
			collision_offset := 0
			set_key_binding (a_key_binding)
		    trajectory.enable_degree_mode
			speed := 1
		end

feature -- Output

	out: STRING_8
		do
			result := "player"
		end

feature -- Access

	update
		local
			l_projectile: PROJECTILE
		do
			if shoot then
				projectile_delay := (projectile_delay + 1) \\ 20

				if projectile_delay = 0 then
					l_projectile := create {PROJECTILE}.make ("bullet_red", window, x + (width / 2).floor, y + (height / 2).floor, current)
					l_projectile.trajectory.enable_degree_mode
					l_projectile.trajectory.set_angle (90)
					l_projectile.trajectory.set_force (3)
					on_creation.call (l_projectile)
				end
			end

			if is_moving_up then
				trajectory.set_y (speed)
			elseif is_moving_down then
				trajectory.set_y (-speed)
			else
				trajectory.set_y (0)
			end

			if is_moving_left then
				trajectory.set_x (-speed)
			elseif is_moving_right then
				trajectory.set_x (speed)
			else
				trajectory.set_x (0)
			end

			if (is_moving_up and (is_moving_left or is_moving_right)) or (is_moving_down and (is_moving_left or is_moving_right)) then
				trajectory.set_force (speed)
			end

			if y <= -height / 3 then
				set_y (-height / 3)
			elseif y >= window.height - 2 * (height / 3) then
				set_y (window.height - 2 * (height / 3))
			end

			if x <= -width / 3 then
				set_x (-width / 3)
			elseif x >= window.width - 2 * (width / 3) - 75 then
				set_x (window.width - 2 * (width / 3) - 75)
			end

			precursor {SHIP}
			type := type + ".player"
		end

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		do
			if a_state = true then
				if a_key = key_binding.move_up_key then
					is_moving_up := true
				elseif a_key = key_binding.move_down_key then
					is_moving_down := true
				elseif a_key = key_binding.move_left_key then
					is_moving_left := true
				elseif a_key = key_binding.move_right_key then
					is_moving_right := true
				elseif a_key = key_binding.fire_key then
					shoot := true
				elseif a_key = key_binding.modifier_key then
					speed := 0.4
				end
			else
				if a_key = key_binding.move_up_key then
					is_moving_up := false
				elseif a_key = key_binding.move_down_key then
					is_moving_down := false
				elseif a_key = key_binding.move_left_key then
					is_moving_left := false
				elseif a_key = key_binding.move_right_key then
					is_moving_right := false
				elseif a_key = key_binding.fire_key then
					shoot := false
				elseif a_key = key_binding.modifier_key then
					speed := 1
				end
			end
		end

feature -- Element change

	set_key_binding (a_key_binding: KEYS)
		do
			key_binding := a_key_binding
		end

feature {NONE} -- Implementation

	key_binding: KEYS
	speed: DOUBLE
	shoot: BOOLEAN
	is_moving_up, is_moving_down, is_moving_left, is_moving_right: BOOLEAN
	projectile_delay: NATURAL_8

end
