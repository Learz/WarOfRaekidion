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

	quit
		do
			must_quit := true
		end

feature -- Status

	must_quit, is_server, is_init, connexion_error: BOOLEAN

feature {NONE} -- Implementation

	execute
		do
			from
				must_quit := false
			until
				must_quit
			loop
				if is_init then
					if attached node as la_node then
						la_node.receive_data
					else
						connexion_error := true
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
									connexion_error := true
								end
							else
								connexion_error := true
							end
						else
							create node.make_client (address, 9001)

							if attached node as la_node then
								if attached la_node.distant_socket as la_socket then
									if la_socket.is_connected then
										is_init := true
									else
										la_node.close
										connexion_error := true
									end
								else
									la_node.close
									connexion_error := true
								end
							else
								connexion_error := true
							end
						end
					end
				end

				if not connexion_error and attached node as la_node then
					connexion_error := la_node.connexion_error
				end
			end

			if attached node as la_node then
				la_node.close
			end

			exit
		end

end
