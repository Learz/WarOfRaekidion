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
			l_address: INET_ADDRESS_FACTORY
		do
			create l_address
			client_address := l_address.create_from_name (a_address)
			port := a_port
			io.put_string ("Opening client on: "+client_address+":"+port.out+".%N")

			if client_address = Void then
				io.put_string ("Address " + a_address + " is invalid.%N")
			else
				create client.make_client_by_address_and_port (client_address, port)

				if client.invalid_address then
					io.put_string ("Impossible to connect to "+a_address+":"+port.out+".%N")
				else
					client.connect

					if not client.is_connected then
						io.put_string ("Impossible to connect to "+a_address+":"+port.out+".%N")
					else
						client.put_string (client_address.host_address.host_address)
						client.read_line
						io.put_string ("Server sent: "+client.last_string+"%N")
						client.close
					end
				end
			end
		end

	make_server (a_port: INTEGER)
		do
			server_address := ""
			port := a_port
			io.put_string ("Opening server on port "+l_port.out+".%N")
			create server.make_server_by_port (port)

			if not server.is_bound then
				io.put_string ("Port "+port.out+" already in use")
			else
				server_address := server.address

				check
					Address_attached: server_address /= void
				end

				io.put_string ("Socket open and bound to: "+server_address.host_address.host_address+":"+server_address.port.out+".%N")
				server.listen (1)
				server.accept
				client := server.accepted

				if client = void then
					io.put_string ("Impossible to connect to client.%N")
				else
					client_address := server.peer_address

					check
						Client_address_attached: client_address /= void
					end

					io.put_string ("Connected to client: "+client_address.host_address.host_address+":"+client_address.port.out+".%N")
					client.read_line
					io.put_string ("Client sent: "+client.last_string+"%N")
					client.put_string (server_address.host_address.host_address)
					client.close
				end
			end
			server.close
		end

feature -- Access

	client, server: NETWORK_STREAM_SOCKET
	client_address, server_address: NETWORK_SOCKET_ADDRESS
	port: INTEGER

	recieve_player_position: TUPLE [INTEGER, INTEGER]
		local
			l_packet: detachable PACKET
			l_x, l_y: INTEGER
		do
			l_packet := socket.receive (64, 0)

			if attached l_packet as la_packet then
				l_x := la_packet.data.read_integer_32 (0)
				l_y := la_packet.data.read_integer_32 (32)
			end

			result := [l_x, l_y]
		end

	recieve_new_enemy_ship: TUPLE [STRING, INTEGER, INTEGER]
		local
			l_packet: detachable PACKET
			l_name_count, l_name_maximum: INTEGER
			l_name: STRING
			l_x, l_y: INTEGER
		do
			l_packet := socket.receive (128, 0)
			create l_name.make_empty

			if attached l_packet as la_packet then
				l_name_maximum := la_packet.data.read_integer_32 (0)

				from
					l_name_count := 0
				until
					l_name_count = l_name_maximum
				loop
					l_name.append_character (la_packet.data.read_character (32 + l_name_count))
					l_name_count := l_name_count + 1
				end

				l_x := la_packet.data.read_integer_32 (64)
				l_y := la_packet.data.read_integer_32 (96)
			end

			result := [l_name, l_x, l_y]
		end

	send_player_position (a_x, a_y: INTEGER)
		local
			l_packet: PACKET
		do
			create l_packet.make (64)
			l_packet.data.put_integer_32 (a_x, 0)
			l_packet.data.put_integer_32 (a_y, 32)
			socket.send (l_packet, 0)
		end

	send_new_enemy_ship (a_name: STRING; a_x, a_y: INTEGER)
		local
			l_packet: PACKET
			l_name_count: INTEGER
		do
			create l_packet.make (128)
			l_packet.data.put_integer_32 (a_name.count, 0)

			from
				l_name_count := 0
			until
				l_name_count = a_name.count
			loop
				l_packet.data.put_character (a_name.at (l_name_count), 32)
				l_name_count := l_name_count + 1
			end

			l_packet.data.put_integer_32 (a_x, 64)
			l_packet.data.put_integer_32 (a_y, 96)
		end

end
