note
	description: "Summary description for {SPAWNER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPAWNER

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_player: BOOLEAN; a_network: detachable NETWORK)
		do
			window := a_window
			key_binding := a_key_binding
			is_player := a_is_player

			if attached a_network as la_network then
				network := la_network
			end

			create random.make
		    create on_spawn
			create spawn_list.make
		end

feature -- Status

	is_player: BOOLEAN

feature -- Access

	on_spawn: ACTION_SEQUENCE [TUPLE [a_enemy_ship: ENEMY_SHIP]]
	spawn_list: LINKED_LIST [TUPLE [name: STRING; x, y, dest_x, dest_y: INTEGER]]

	update
		do

			from
				spawn_list.start
			until
				spawn_list.exhausted
			loop
				on_spawn.call (create {ENEMY_SHIP}.make (spawn_list.item.name, window, spawn_list.item.x, spawn_list.item.y, spawn_list.item.dest_x, spawn_list.item.dest_y))
				spawn_list.remove
			end
		end

	destroy
		do
			on_spawn.wipe_out
		end

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		local
			l_x, l_y: INTEGER
		do
			if a_state then
				if a_key = key_binding.action_key then
					l_x := (random.double_item * 200).floor
					random.forth
					l_y := (random.double_item * 200).floor - 50
					random.forth
					spawn_list.extend (["sprayer", (random.double_item * 200).floor, -25, l_x, l_y])
					random.forth
				end
			end
		end

feature {NONE} -- Implementation

	network: detachable NETWORK
	random: RANDOM
	window: WINDOW
	key_binding: KEYS

end
