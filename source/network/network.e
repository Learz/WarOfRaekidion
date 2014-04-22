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
	make_server,
	make_client

feature {NONE} -- Initialization

	make_server
		do
			make
			create address.make_empty
			is_server := true
		end

	make_client (a_address: STRING)
		do
			make
			address := a_address
			is_server := false
		end

feature -- Access

	node: detachable NODE
	timer, delay, timeout: INTEGER
	address: STRING
	player_ship: detachable PLAYER_SHIP
	spawner: detachable SPAWNER

	quit
		do
			must_quit := true
		end

feature -- Status

	must_quit, is_server, is_init: BOOLEAN

feature -- Element change

	set_player_and_spawner (a_player_ship: PLAYER_SHIP; a_spawner: SPAWNER)
		do
			player_ship := a_player_ship
			spawner := a_spawner
		end

feature {NONE} -- Implementation

	execute
		do
			from
				must_quit := false
			until
				must_quit
			loop
				if attached node as la_node then
					if is_init then
						if is_server then
							if attached spawner as la_spawner then
		--						la_node.receive_client_data
							end
						else
							if attached player_ship as la_player_ship then
		--						la_node.receive_server_data
							end
						end
					else
						if is_server then
							create node.make_server (9001)
							is_init := true
						else
							create node.make_client (address, 9001)

							if attached la_node.socket as la_socket then
								if la_socket.is_connected then
									is_init := true
								else
									io.put_string (address)
								end
							end
						end
					end
				end
			end

			if attached node as la_node then
				la_node.close
			end

			exit
		end

end
