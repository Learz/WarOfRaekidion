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

	quit
		do
			must_quit := true
		end

feature -- Status

	must_quit, is_ship: BOOLEAN

feature {NONE} -- Implementation

	player_ship: PLAYER_SHIP
	spawner: SPAWNER
	node: NODE

	execute
		do
			from
				must_quit := true
			until
				not must_quit
			loop
				if is_ship then
					
				else

				end
			end

		end

end
