note
	description : "War of Raekidion - {PLAYER_SHIP} class"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PLAYER_SHIP

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

	make (a_window: WINDOW; a_x, a_y: DOUBLE; a_key_binding: KEYS; a_is_player: BOOLEAN)
		do
			ship_make ("player", a_window, a_x, a_y, 100)
			is_player := a_is_player
			offset := 16
			set_key_binding (a_key_binding)
		    trajectory.enable_degree_mode
			speed := 4
		end

feature -- Access

	update
		do
			if shoot_delay <= 0 then
				if is_shooting then
					on_shoot.call (["White laser", x.floor, y.floor, 90.0, Current])
					shoot_delay := 6
				end
			else
				shoot_delay := shoot_delay - 1
			end

			if is_moving_up or is_moving_down or is_moving_left or is_moving_right then
				has_moved := true
			else
				has_moved := false
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

			precursor {SHIP}

			if y <= height / 3 then
				set_y (height / 3)
			elseif y >= window.height - height / 3 then
				set_y (window.height - height / 3)
			end

			if x <= width / 3 then
				set_x (width / 3)
			elseif x >= window.width - width / 3 - 75 then
				set_x (window.width - width / 3 - 75)
			end
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
					is_shooting := true
				elseif a_key = key_binding.modifier_key then
					speed := 1
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
					is_shooting := false
				elseif a_key = key_binding.modifier_key then
					speed := 4
				end
			end
		end

feature -- Status

	has_moved: BOOLEAN
	is_player: BOOLEAN
	is_shooting: BOOLEAN
	is_moving_up, is_moving_down, is_moving_left, is_moving_right: BOOLEAN

feature -- Element change

	set_key_binding (a_key_binding: KEYS)
		do
			key_binding := a_key_binding
		end

feature {NONE} -- Implementation

	shoot_delay: INTEGER
	key_binding: KEYS
	speed: DOUBLE

end
