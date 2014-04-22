note
	description: "Summary description for {NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NODE

create
	make_client,
	make_server

feature {NONE} -- Initialization

	make_client (a_address: STRING; a_port: INTEGER)
		local
			l_address: detachable INET_ADDRESS
			l_address_factory: INET_ADDRESS_FACTORY
		do
			create l_address_factory
			l_address := l_address_factory.create_from_name (a_address)

			if attached l_address as la_address then
				create socket.make_client_by_address_and_port (l_address, a_port)

				if attached socket as la_socket then
					la_socket.connect
				end
			end
		end

	make_server (a_port: INTEGER)
		local
			l_other_socket: NETWORK_STREAM_SOCKET
		do
			create l_other_socket.make_server_by_port (a_port)
			l_other_socket.listen (1)
			l_other_socket.accept
			socket := l_other_socket.accepted
			l_other_socket.close
		end

feature -- Access

	socket: detachable NETWORK_STREAM_SOCKET

	close
		do
			if attached socket as la_socket then
				la_socket.close
			end
		end

end
