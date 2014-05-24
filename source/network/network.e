note
	description	: "[
					War of Raekidion - A network thread
					A {NETWORK} is a bridge between the application and another 
					distant application. Reception is done in a new thread.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	NETWORK

inherit
	THREAD

create
	make_server,
	make_client

feature {NONE} -- Initialization

	make_server
		-- Initialize `Current'
		do
			make
			create address.make_empty
			is_server := true
		end

	make_client (a_address: STRING)
		-- Initialize `Current' from `a_address'
		do
			make
			address := a_address
			is_server := false
		end

feature -- Access

	node: detachable NODE
		-- The node is used to make the connection between the two game instances

	address: STRING
		-- The server address

	quit
		-- Gracefully end execution of `Current'
		do
			must_quit := true
		end

feature -- Status

	must_quit: BOOLEAN
		-- True if the network socket must be closed

	is_server: BOOLEAN
		-- Is the class initialized as a server?

	is_init: BOOLEAN
		-- Is the socket bound or connected?

	connection_error: BOOLEAN
		-- Has a networking error happened?

feature {NONE} -- Implementation

	execute
		-- Create the sockets, then receive data
		do
			from
				must_quit := false
			until
				must_quit
			loop
				if connection_error then
					if attached node as la_node then
						la_node.close
					end

					quit
					exit
				else
					if attached node as la_node then
						connection_error := la_node.connection_error
					end

					if is_init then
						if attached node as la_node then
							if la_node.connection_error then
								connection_error := true
							else
								la_node.receive_data
							end
						else
							connection_error := true
						end
					else
						if not attached node as la_node then
							if is_server then
								create node.make_server (9001)

								if attached node as la_node then
									if attached la_node.distant_socket as la_socket then
										is_init := true
									else
										la_node.close
										connection_error := true
									end
								else
									connection_error := true
								end
							else
								create node.make_client (address, 9001)

								if attached node as la_node then
									if attached la_node.distant_socket as la_socket then
										if la_socket.is_connected then
											is_init := true
										else
											la_node.close
											connection_error := true
										end
									else
										la_node.close
										connection_error := true
									end
								else
									connection_error := true
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

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
