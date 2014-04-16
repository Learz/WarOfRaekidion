note
	description : "War of Raekidion - {NETWORK} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date: "$Date$"
	revision: "$Revision$"

class
	NETWORK

inherit
	THREAD

create
	make_waiting,
	make_game

feature {NONE} -- Initialization

	make_waiting (a_is_ship: BOOLEAN; a_address: STRING)
		do
			make
			waiting := true
			is_ship := a_is_ship
			create connected_ip.make_empty

			if is_ship then
				create node.make_client (a_address, 9001)
			else
				create node.make_server (9001)
			end
		end

	make_game (a_player_ship: PLAYER_SHIP; a_spawner: SPAWNER; a_is_ship: BOOLEAN; a_address: STRING)
		do
			make
			waiting := false
			is_ship := a_is_ship
			player_ship := a_player_ship
			spawner := a_spawner
			create connected_ip.make_empty

			if is_ship then
				create node.make_client (a_address, 9001)
			else
				create node.make_server (9001)
			end
		end

feature -- Access

	node: NODE
	connected_ip: STRING
	player_ship: detachable PLAYER_SHIP
	spawner: detachable SPAWNER

	quit
		do
			must_quit := true
		end

feature -- Status

	must_quit, is_ship, waiting: BOOLEAN

feature -- Element change

	set_player_and_spawner (a_player_ship: PLAYER_SHIP; a_spawner: SPAWNER)
		do
			player_ship := a_player_ship
			spawner := a_spawner
		end

feature {NONE} -- Implementation

	execute
		do
			if waiting then
				execute_waiting
			else
				execute_game
			end
		end

	execute_waiting
		do
			if is_ship then
				node.send_ip
			else
				connected_ip := node.recieve_ip
			end
		end

	execute_game
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
					if attached spawner as la_spawner then
						l_enemy_ship := node.recieve_new_enemy_ship
						la_spawner.spawn_list.extend (l_enemy_ship)
					end
				else
					if attached player_ship as la_player_ship then
						l_player_position := node.recieve_player_position
						la_player_ship.set_x (l_player_position.x)
						la_player_ship.set_y (l_player_position.y)
					end
				end
			end
		end

end
