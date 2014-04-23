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
				create local_socket.make_client_by_address_and_port (l_address, a_port)

				if attached local_socket as la_socket then
					la_socket.connect
				else
					connexion_error := true
				end
			else
				connexion_error := true
			end
		end

	make_server (a_port: INTEGER)
		do
			create local_socket.make_server_by_port (a_port)

			if attached local_socket as la_socket then
				la_socket.listen (1)
				la_socket.accept
				distant_socket := la_socket.accepted
			else
				connexion_error := true
			end
		end

feature -- Status

	connexion_error: BOOLEAN

feature -- Access

	local_socket, distant_socket: detachable NETWORK_STREAM_SOCKET

	send_new_enemy_ship (a_name: STRING; a_x, a_y: INTEGER)
		local
			l_count: INTEGER
			l_packet: PACKET
		do
			create l_packet.make (128 + (a_name.count * 8))
			l_packet.data.put_integer_32 (1, 0)
			l_packet.data.put_integer_32 (a_x, 32)
			l_packet.data.put_integer_32 (a_y, 64)
			l_packet.data.put_integer_32 (a_name.count, 96)

			from
				l_count := 0
			until
				l_count = a_name.count
			loop
				l_count := l_count + 1
				l_packet.data.put_character (a_name.at (l_count), 128)
			end

			if attached local_socket as la_socket then
				la_socket.write (l_packet)
			end
		end

	send_player_position (a_x, a_y: INTEGER)
		local
			l_packet: PACKET
		do
			create l_packet.make (96)
			l_packet.data.put_integer_32 (2, 0)
			l_packet.data.put_integer_32 (a_x, 32)
			l_packet.data.put_integer_32 (a_y, 64)

			if attached local_socket as la_socket then
				la_socket.write (l_packet)
			end
		end

	send_projectile (a_name: STRING; a_x, a_y, a_angle: INTEGER)
		local
			l_count: INTEGER
			l_packet: PACKET
		do
			create l_packet.make (160 + (a_name.count * 8))
			l_packet.data.put_integer_32 (3, 0)
			l_packet.data.put_integer_32 (a_x, 32)
			l_packet.data.put_integer_32 (a_y, 64)
			l_packet.data.put_integer_32 (a_angle, 92)
			l_packet.data.put_integer_32 (a_name.count, 128)

			from
				l_count := 0
			until
				l_count = a_name.count
			loop
				l_count := l_count + 1
				l_packet.data.put_character (a_name.at (l_count), 160)
			end

			if attached local_socket as la_socket then
				la_socket.write (l_packet)
			end
		end

	close
		do
			if attached distant_socket as la_socket then
				la_socket.close
			end

			if attached local_socket as la_socket then
				la_socket.close
			end
		end

end
