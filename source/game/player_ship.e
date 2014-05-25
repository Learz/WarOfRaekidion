note
	description	: "[
					War of Raekidion - The player ship
					A {PLAYER_SHIP} is a controllable ship that triggers 
					an "end game" event when it dies.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

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
		-- Initialize `Current' from `a_window', `a_x', `a_y', `a_key_binding' and `a_is_player'
		do
			ship_make ("player", a_window, a_x, a_y, 100, 5)
			is_player := a_is_player
			offset := 16
			max_energy := 100
			set_key_binding (a_key_binding)
		    trajectory.enable_degree_mode
			speed := 4
			create random.make
		end

feature -- Access

	energy: DOUBLE assign set_energy
		-- Energy available for focusing

	max_energy: DOUBLE
		-- Maximum energy possible

	update
		-- Update `Current' on screen
		local
			l_random_int: INTEGER
			l_spread: INTEGER
		do
			if is_disabled then
				is_focus := false
				disabled_time := disabled_time - 1

				if disabled_time <= 0 then
					enable
				end
			else
				if shoot_delay <= 0 then
					if is_shooting then
						if is_focus then
							if previous_firerate.ceiling <= 6 then
								if previous_firerate.ceiling >= 3 then
									previous_firerate := previous_firerate - 0.1

									if energy > 0 then
										shoot_delay := previous_firerate.ceiling
										energy := energy - ((6 / previous_firerate) * 0.25)
									else
										shoot_delay := 6
									end
								else
									if energy > 0 then
										shoot_delay := 3
										energy := energy - 1
									else
										shoot_delay := 6
									end
								end
							else
								previous_firerate := 6
							end

							l_spread := (previous_firerate.ceiling - 3) * 3
							l_random_int := (random.double_item * l_spread).floor - (l_spread / 2).floor
						else
							l_random_int := (random.double_item * 10).floor - 5
							shoot_delay := 6
							previous_firerate := 6
						end

						random.forth
						on_shoot.call (["White laser", x.floor, y.floor, 90.0 + l_random_int, Current])
					end
				else
					shoot_delay := shoot_delay - 1
				end

				if is_focus then
					speed := 1
				else
					speed := 4
				end
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

	disable (a_time: INTEGER)
		-- Disables the player from shooting, focusing and taking damage
		do
			is_disabled := true
			disabled_time := a_time
			{SDL}.sdl_settexturealphamod (texture, 100)
		end

	enable
		-- Re-enables the player to shoot, focus and take damage
		do
			is_disabled := false
			{SDL}.sdl_settexturealphamod (texture, 255)
		end

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		-- Manage `a_key' and `a_state'
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
					is_focus := true
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
					is_focus := false
				end
			end
		end

feature -- Status

	has_moved: BOOLEAN
		-- True if the `Current' position changed since last frame

	is_disabled: BOOLEAN
		-- True if the ship cannot shoot, focus and take damage

	is_player: BOOLEAN
		-- True if the ship is controllable by the player

	is_focus: BOOLEAN
		-- True if the player should focus

	is_shooting: BOOLEAN
		-- True if the player should shoot

	is_moving_up: BOOLEAN
		-- True if the ship is moving up

	is_moving_down: BOOLEAN
		-- True if the ship is moving down

	is_moving_left: BOOLEAN
		-- True if the ship is moving left

	is_moving_right: BOOLEAN
		-- True if the ship is moving right

feature -- Element change

	set_energy (a_energy: DOUBLE)
		-- Assign `energy' to `a_energy'
		do
			if a_energy > max_energy then
				energy := max_energy
			elseif a_energy < 0 then
				energy := 0
			else
				energy := a_energy
			end
		end

	set_key_binding (a_key_binding: KEYS)
		-- Assign `key_binding' to `a_key_binding'
		do
			key_binding := a_key_binding
		end

feature {NONE} -- Implementation

	previous_firerate: DOUBLE
		-- The previous framerate for progressive reduction

	disabled_time: INTEGER
		-- The time for which the player will be disabled

	random: RANDOM
		-- The random number generator

	shoot_delay: INTEGER
		-- Number of frames between each shot

	key_binding: KEYS
		-- The current keys allowing the ship to move

	speed: DOUBLE
		-- The ship's speed

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
