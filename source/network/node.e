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
			create new_enemies.make
			new_player_position := [112, 300]
			create new_projectiles.make
			create new_collisions.make
			create l_address_factory
			l_address := l_address_factory.create_from_name (a_address)

			if attached l_address as la_address then
				create distant_socket.make_client_by_address_and_port (l_address, a_port)

				if attached distant_socket as la_socket then
--					io.put_string ("Connecting...") ; io.put_new_line
					la_socket.connect

					if not la_socket.is_connected then
						connexion_error := true
--						io.put_string ("Connexion error. (socket disconnected)") ; io.put_new_line
					else
--						io.put_string ("Connection accepted!") ; io.put_new_line
					end
				else
					connexion_error := true
--					io.put_string ("Connexion error. (socket does not exist)") ; io.put_new_line
				end
			else
				connexion_error := true
--				io.put_string ("Connexion error. (invalid address)") ; io.put_new_line
			end
		end

	make_server (a_port: INTEGER)
		do
			create new_enemies.make
			new_player_position := [112, 300]
			create new_projectiles.make
			create new_collisions.make
			create local_socket.make_server_by_port (a_port)

			if attached local_socket as la_socket then
--				io.put_string ("Listening...") ; io.put_new_line
				la_socket.listen (1)
				la_socket.accept
				distant_socket := la_socket.accepted
--				io.put_string ("Accepted connection!") ; io.put_new_line

				if la_socket.was_error then
					connexion_error := true
--					io.put_string ("Connexion error. (socket disconnected)") ; io.put_new_line
				end
			else
				connexion_error := true
--				io.put_string ("Connexion error. (socket does not exist)") ; io.put_new_line
			end
		end

feature -- Status

	connexion_error: BOOLEAN

feature -- Access

	local_socket, distant_socket: detachable NETWORK_STREAM_SOCKET
	new_enemies: LINKED_LIST [TUPLE [name: STRING; x, y, dest_x, dest_y: INTEGER]]
	new_player_position: TUPLE [x, y: INTEGER]
	new_projectiles: LINKED_LIST [TUPLE [name: STRING; x, y: INTEGER; angle: DOUBLE]]
	new_collisions: LINKED_LIST [TUPLE [enemy_id, projectile_id: INTEGER]]

	receive_data
		local
			l_choice: INTEGER
			l_packet: detachable PACKET
			l_count: INTEGER
			l_string: STRING
		do
			l_string := ""

			if attached distant_socket as la_socket then
				if la_socket.is_readable and la_socket.is_open_read then
					l_packet := la_socket.receive (256, 0)

					if attached l_packet as la_packet then
						l_choice := l_packet.data.read_integer_32 (0)

						if l_choice = 1 then

								-- Enemy creation is 1

							from
								l_count := 0
							until
								l_count = la_packet.data.read_integer_32 (160)
							loop
								l_string.append_character (l_packet.data.read_character (192 + l_count))
							end

							new_enemies.extend (l_string, la_packet.data.read_integer_32 (32), la_packet.data.read_integer_32 (64),
														  la_packet.data.read_integer_32 (96), la_packet.data.read_integer_32 (128))
						elseif l_choice = 2 then

								-- Player movement is 2

							new_player_position := [la_packet.data.read_integer_32 (32), la_packet.data.read_integer_32 (64)]
						elseif l_choice = 3 then

								-- Projectile creation is 3

							from
								l_count := 0
							until
								l_count = la_packet.data.read_integer_32 (160)
							loop
								l_string.append_character (l_packet.data.read_character (192 + l_count))
							end

							new_projectiles.extend (l_string, la_packet.data.read_integer_32 (32),
								la_packet.data.read_integer_32 (64), la_packet.data.read_real_64 (96))
						elseif l_choice = 4 then

								-- Collision is 4

							new_collisions.extend (la_packet.data.read_integer_32 (32), la_packet.data.read_integer_32 (64))
						end
					end
				end
			end
		end

	send_new_enemy_ship (a_name: STRING; a_x, a_y, a_dest_x, a_dest_y: INTEGER)
		local
			l_count: INTEGER
			l_packet: PACKET
		do
			create l_packet.make (192 + (a_name.count * 8))
			l_packet.data.put_integer_32 (1, 0)
			l_packet.data.put_integer_32 (a_x, 32)
			l_packet.data.put_integer_32 (a_y, 64)
			l_packet.data.put_integer_32 (a_x, 96)
			l_packet.data.put_integer_32 (a_y, 128)
			l_packet.data.put_integer_32 (a_name.count, 160)

			from
				l_count := 0
			until
				l_count = a_name.count
			loop
				l_count := l_count + 1
				l_packet.data.put_character (a_name.at (l_count), 192)
			end

			if attached distant_socket as la_socket then
				if la_socket.is_writable and la_socket.is_open_write then
					la_socket.send (l_packet, 0)
				end
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

			if attached distant_socket as la_socket then
				if la_socket.is_writable and la_socket.is_open_write then
					la_socket.send (l_packet, 0)
				end
			end
		end

	send_projectile (a_name: STRING; a_x, a_y: INTEGER; a_angle: DOUBLE)
		local
			l_count: INTEGER
			l_packet: PACKET
		do
			create l_packet.make (192 + (a_name.count * 8))
			l_packet.data.put_integer_32 (3, 0)
			l_packet.data.put_integer_32 (a_x, 32)
			l_packet.data.put_integer_32 (a_y, 64)
			l_packet.data.put_real_64 (a_angle, 92)
			l_packet.data.put_integer_32 (a_name.count, 160)

			from
				l_count := 0
			until
				l_count = a_name.count
			loop
				l_count := l_count + 1
				l_packet.data.put_character (a_name.at (l_count), 192)
			end

			if attached distant_socket as la_socket then
				if la_socket.is_writable and la_socket.is_open_write then
					la_socket.send (l_packet, 0)
				end
			end
		end

	send_collision (a_enemy_id, a_projectile_id: INTEGER)
		local
			l_packet: PACKET
		do
			create l_packet.make (96)
			l_packet.data.put_integer_32 (4, 0)
			l_packet.data.put_integer_32 (a_enemy_id, 32)
			l_packet.data.put_integer_32 (a_projectile_id, 64)

			if attached distant_socket as la_socket then
				if la_socket.is_writable and la_socket.is_open_write then
					la_socket.send (l_packet, 0)
				end
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
