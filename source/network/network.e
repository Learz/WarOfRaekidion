note
	description : "War of Raekidion - {NETWORK} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date: "$Date$"
	revision: "$Revision$"

class
	NETWORK

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_player_ship: PLAYER_SHIP; a_spawner: SPAWNER; a_is_ship: BOOLEAN; a_address: STRING)
		do
			thread_make
			player_ship := a_player_ship
			spawner := a_spawner
			is_ship := a_is_ship

			if is_ship then
				create node.make_client (a_address, 9001)
			else
				create node.make_server (9001)
			end
		end

feature -- Access

	node: NODE
	player_ship: PLAYER_SHIP
	spawner: SPAWNER

	quit
		do
			must_quit := true
		end

feature -- Status

	must_quit, is_ship: BOOLEAN

feature {NONE} -- Implementation

	execute
		local
			l_enemy_ship: TUPLE [name: STRING; x, y: INTEGER]
			l_player_position: TUPLE [x, y: INTEGER]
		do
			from
				must_quit := false
			until
				must_quit
			loop
				if is_ship then
					l_enemy_ship := node.recieve_new_enemy_ship
					spawner.spawn_list.extend (l_enemy_ship)
				else
					l_player_position := node.recieve_player_position
					player_ship.set_x (l_player_position.x)
					player_ship.set_y (l_player_position.y)
				end
			end

		end

end
