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
			money := 20
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
				l_x := (random.double_item * 200).floor + 12
				random.forth
				l_y := (random.double_item * 100).floor + 12
				random.forth

				if (random.double_item * 5).floor = 0 then
					random.forth
					spawn_list.extend (["Sprayer", (random.double_item * 200).floor + 12, -25, l_x, l_y])
				elseif (random.double_item * 5).floor = 1 then
					random.forth
					spawn_list.extend (["Mauler", (random.double_item * 200).floor + 12, -25, l_x, l_y])
				elseif (random.double_item * 5).floor = 2 then
					random.forth
					spawn_list.extend (["Homing", (random.double_item * 200).floor + 12, -25, l_x, l_y])
				elseif (random.double_item * 5).floor = 3 then
					random.forth
					spawn_list.extend (["Laser", (random.double_item * 200).floor + 12, -25, l_x, l_y])
				elseif (random.double_item * 5).floor = 4 then
					random.forth
					spawn_list.extend (["Spiral", (random.double_item * 200).floor + 12, -25, l_x, l_y])
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
		do
			on_spawn.wipe_out
		end

feature -- Element change

	set_key_binding (a_key_binding: KEYS)
		do
			key_binding := a_key_binding
		end
		
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
