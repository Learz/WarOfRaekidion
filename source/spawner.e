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

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_player: BOOLEAN)
		do
			window := a_window
			key_binding := a_key_binding
			is_player := a_is_player
		    create on_spawn
			create spawn_list.make
		end

feature -- Status

	is_player: BOOLEAN

feature -- Access

	on_spawn: ACTION_SEQUENCE [TUPLE [a_enemy_ship: ENEMY_SHIP]]
	spawn_list: LINKED_LIST [TUPLE [name: STRING; x, y: INTEGER]]

	update
		do
			from
				spawn_list.start
			until
				spawn_list.exhausted
			loop
				on_spawn.call (create {ENEMY_SHIP}.make (spawn_list.item.name, window, spawn_list.item.x, spawn_list.item.y))
				spawn_list.remove
			end
		end

	destroy
		do
			on_spawn.wipe_out
		end

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		do
			if a_state then
				if a_key = key_binding.move_down_key then
					spawn_list.extend (["enemy_red", 100, 100])
				end
			end
		end

feature {NONE} -- Implementation

	window: WINDOW
	key_binding: KEYS

end
