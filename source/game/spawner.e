note
	description	: "[
					War of Raekidion - The spawner
					A {SPAWNER} is a controllable entity that creates 
					enemy ships in order to destroy the player ship.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	SPAWNER

inherit
	ENEMY_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_player: BOOLEAN)
		-- Initialize `Current' from `a_window', `a_key_binding' and `a_is_player'
		do
			window := a_window
			key_binding := a_key_binding
			is_player := a_is_player
			create random.make
		    create on_spawn
			create spawn_list.make
			money := 20
		end

feature -- Status

	is_player: BOOLEAN
		-- True if `Current' is controllable

	is_ai: BOOLEAN
		-- True if `Current' acts by itself

feature -- Access

	money: INTEGER
		-- The currency with which `Current' can buy more ships

	on_spawn: ACTION_SEQUENCE [TUPLE [name: STRING; x, y, dest_x, dest_y: INTEGER]]
		-- The list of spawning events

	spawn_list: LINKED_LIST [TUPLE [name: STRING; x, y, dest_x, dest_y: INTEGER]]
		-- The list of ships to spawn next

	update
		-- Update `Current'
		local
			l_x, l_y, l_random, l_side: INTEGER
		do
			if is_ai then
				random.forth
				l_x := (random.double_item * 200).floor + 12
				random.forth
				l_y := (random.double_item * 200).floor + 12
				random.forth
				l_random := (random.double_item * enemy_factory.file_list.count).floor + 1
				random.forth
				l_side := (random.double_item * 3).floor
				random.forth

				if l_side = 0 then
					spawn_list.extend ([enemy_factory.file_list.at (l_random).name, (random.double_item * 200).floor + 12, -25, l_x, l_y])
				elseif l_side = 1 then
					spawn_list.extend ([enemy_factory.file_list.at (l_random).name, -25, (random.double_item * 200).floor + 12, l_x, l_y])
				else
					spawn_list.extend ([enemy_factory.file_list.at (l_random).name, 250, (random.double_item * 200).floor + 12, l_x, l_y])
				end
			end

			from
				spawn_list.start
			until
				spawn_list.exhausted
			loop
				on_spawn.call (spawn_list.item)
				spawn_list.remove
			end
		end

	destroy
		-- Destroy `Current'
		do
			on_spawn.wipe_out
		end

feature -- Element change

	set_key_binding (a_key_binding: KEYS)
		-- Assign `key_binding' to `a_key_binding'
		do
			key_binding := a_key_binding
		end

	set_ai (a: BOOLEAN)
		-- Assign `is_ai' to `a'
		do
			is_ai := a
		end

	set_money (a_money: INTEGER)
		-- Assign `money' to `a_money'
		do
			money := a_money
		end

feature {NONE} -- Implementation

	random: RANDOM
		-- The random number generator

	window: WINDOW
		-- The window in which to spawn the ships

	key_binding: KEYS
		-- The current key binding

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
