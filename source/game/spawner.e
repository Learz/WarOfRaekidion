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
			create random.make
		    create on_spawn
			create spawn_list.make
			money := 50
		end

feature -- Status

	is_player, is_ai: BOOLEAN

feature -- Access

	money: INTEGER
	on_spawn: ACTION_SEQUENCE [TUPLE [name: STRING; x, y, dest_x, dest_y: INTEGER]]
	spawn_list: LINKED_LIST [TUPLE [name: STRING; x, y, dest_x, dest_y: INTEGER]]

	update
		local
			l_x, l_y: INTEGER
		do
			if is_ai then
				random.forth
				l_x := (random.double_item * 200).floor
				random.forth
				l_y := (random.double_item * 100).floor - 50
				random.forth

				if random.double_item > 0.5 then
					spawn_list.extend (["sprayer", (random.double_item * 200).floor, -25, l_x, l_y])
				else
					spawn_list.extend (["mauler", (random.double_item * 200).floor, -25, l_x, l_y])
				end

				random.forth
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
		do
			on_spawn.wipe_out
		end

feature -- Element change

	set_ai (a: BOOLEAN)
		do
			is_ai := a
		end

	set_money (a_money: INTEGER)
		do
			money := a_money
		end

feature {NONE} -- Implementation

	random: RANDOM
	window: WINDOW
	key_binding: KEYS

end
