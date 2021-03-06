note
	description	: "[
					War of Raekidion - A network client or server connection
					A {NODE} is a network class that binds a server to a 
					port or connects a client to a server and a port.
				]"
	author		: "Fran?ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	NODE

create
	make_client,
	make_server

feature {NONE} -- Initialization

	make_client (a_address: STRING; a_port: INTEGER)
		-- Initialize `Current' from `a_address' and `a_port'
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
					la_socket.connect

					if not la_socket.is_connected then
						connection_error := true
					end
				else
					connection_error := true
				end
			else
				connection_error := true
			end
		end

	make_server (a_port: INTEGER)
		-- Initialize `Current' from `a_port'
		do
			create new_enemies.make
			new_player_position := [112, 300]
			create new_projectiles.make
			create new_collisions.make
			create local_socket.make_server_by_port (a_port)

			if attached local_socket as la_socket then
				la_socket.listen (1)
				la_socket.accept
				distant_socket := la_socket.accepted

				if la_socket.was_error then
					connection_error := true
				end
			else
				connection_error := true
			end
		end

feature -- Status

	connection_error: BOOLEAN
		-- True if a connection error occured

feature -- Access

	local_socket: detachable NETWORK_STREAM_SOCKET
		-- The local socket used to identify the server locally

	distant_socket: detachable NETWORK_STREAM_SOCKET
		-- The distant socket used to identify clients or the distant server

	new_enemies: LINKED_LIST [TUPLE [name: STRING; x, y, dest_x, dest_y: INTEGER]]
		-- A list of received enemies to be added into the game

	new_player_position: TUPLE [x, y: INTEGER]
		-- The most recent player's coordinates

	new_projectiles: LINKED_LIST [TUPLE [name: STRING; x, y: INTEGER; angle: DOUBLE]]
		-- A list of projectiles to be spawned on screen

	new_collisions: LINKED_LIST [TUPLE [enemy_id, projectile_id: INTEGER]]
		-- A list of recent collisions to update

	new_score: INTEGER
		-- The post recent opponent's score

	receive_data
		-- Fill variables with distant packets' data
		local
			l_choice: INTEGER
			l_packet: detachable PACKET
			l_count: INTEGER
			l_string: STRING
		do
			if connection_error then
				close
			else
				l_string := ""

				if attached distant_socket as la_socket then
					if la_socket.is_readable and la_socket.is_open_read then
						l_packet := la_socket.receive (4, 0)

						if attached l_packet as la_packet then
							l_count := l_packet.data.read_integer_32 (0)
						end

						l_packet := la_socket.receive (l_count, 0)

						if attached l_packet as la_packet then
							l_choice := l_packet.data.read_integer_32 (0)

							if l_choice = Enemy_packet then
								from
									l_count := 0
								until
									l_count = la_packet.data.read_integer_32 (20)
								loop
									l_string.append_character (l_packet.data.read_character (24 + l_count))
									l_count := l_count + 1
								end

								new_enemies.extend (l_string,
									la_packet.data.read_integer_32 (4),
									la_packet.data.read_integer_32 (8),
									la_packet.data.read_integer_32 (12),
									la_packet.data.read_integer_32 (16))
							elseif l_choice = Player_packet then
								new_player_position := [la_packet.data.read_integer_32 (4), la_packet.data.read_integer_32 (8)]
							elseif l_choice = Projectile_packet then
								from
									l_count := 0
								until
									l_count = la_packet.data.read_integer_32 (20)
								loop
									l_string.append_character (l_packet.data.read_character (24 + l_count))
									l_count := l_count + 1
								end

								new_projectiles.extend (l_string,
									la_packet.data.read_integer_32 (4),
									la_packet.data.read_integer_32 (8),
									la_packet.data.read_real_64 (12))
							elseif l_choice = Collision_packet then
								new_collisions.extend (la_packet.data.read_integer_32 (4), la_packet.data.read_integer_32 (8))
							elseif l_choice = Score_packet then
								new_score := la_packet.data.read_integer_32 (4)
							end
						end
					end
				end
			end
		rescue
			connection_error := true
			retry
		end

	send_new_enemy_ship (a_name: STRING; a_x, a_y, a_dest_x, a_dest_y: INTEGER)
		-- Send a packet containing `a_name', `a_x', `a_y', `a_dest_x' and `a_dest_y'
		local
			l_count: INTEGER
			l_size: PACKET
			l_packet: PACKET
		do
			if connection_error then
				close
			else
				create l_size.make (4)
				l_size.data.put_integer_32 (24 + a_name.count, 0)
				create l_packet.make (24 + a_name.count)
				l_packet.data.put_integer_32 (Enemy_packet, 0)
				l_packet.data.put_integer_32 (a_x, 4)
				l_packet.data.put_integer_32 (a_y, 8)
				l_packet.data.put_integer_32 (a_x, 12)
				l_packet.data.put_integer_32 (a_y, 16)
				l_packet.data.put_integer_32 (a_name.count, 20)

				from
					l_count := 0
				until
					l_count = a_name.count
				loop
					l_count := l_count + 1
					l_packet.data.put_character (a_name.at (l_count), 24)
				end

				if attached distant_socket as la_socket then
					if la_socket.is_writable and la_socket.is_open_write then
						la_socket.send (l_size, 0)
						la_socket.send (l_packet, 0)
					end
				end
			end
		rescue
			connection_error := true
			retry
		end

	send_player_position (a_x, a_y: INTEGER)
		-- Send a packet containing `a_x' and `a_y'
		local
			l_size: PACKET
			l_packet: PACKET
		do
			if connection_error then
				close
			else
				create l_size.make (4)
				l_size.data.put_integer_32 (12, 0)
				create l_packet.make (12)
				l_packet.data.put_integer_32 (Player_packet, 0)
				l_packet.data.put_integer_32 (a_x, 4)
				l_packet.data.put_integer_32 (a_y, 8)

				if attached distant_socket as la_socket then
					if la_socket.is_writable and la_socket.is_open_write then
						la_socket.send (l_size, 0)
						la_socket.send (l_packet, 0)
					end
				end
			end
		rescue
			connection_error := true
			retry
		end

	send_projectile (a_name: STRING; a_x, a_y: INTEGER; a_angle: DOUBLE)
		-- Send a packet containing `a_name', `a_x', `a_y' and `a_angle'
		local
			l_count: INTEGER
			l_size: PACKET
			l_packet: PACKET
		do
			if connection_error then
				close
			else
				create l_size.make (4)
				l_size.data.put_integer_32 (24 + a_name.count, 0)
				create l_packet.make (24 + a_name.count)
				l_packet.data.put_integer_32 (Projectile_packet, 0)
				l_packet.data.put_integer_32 (a_x, 4)
				l_packet.data.put_integer_32 (a_y, 8)
				l_packet.data.put_real_64 (a_angle, 12)
				l_packet.data.put_integer_32 (a_name.count, 20)

				from
					l_count := 0
				until
					l_count = a_name.count
				loop
					l_count := l_count + 1
					l_packet.data.put_character (a_name.at (l_count), 24)
				end

				if attached distant_socket as la_socket then
					if la_socket.is_writable and la_socket.is_open_write then
						la_socket.send (l_size, 0)
						la_socket.send (l_packet, 0)
					end
				end
			end
		rescue
			connection_error := true
			retry
		end

	send_collision (a_enemy_id, a_projectile_id: INTEGER)
		-- Send a packet containing `a_enemy_id' and `a_projectile'
		local
			l_size: PACKET
			l_packet: PACKET
		do
			if connection_error then
				close
			else
				create l_size.make (4)
				l_size.data.put_integer_32 (12, 0)
				create l_packet.make (12)
				l_packet.data.put_integer_32 (Collision_packet, 0)
				l_packet.data.put_integer_32 (a_enemy_id, 4)
				l_packet.data.put_integer_32 (a_projectile_id, 8)

				if attached distant_socket as la_socket then
					if la_socket.is_writable and la_socket.is_open_write then
						la_socket.send (l_size, 0)
						la_socket.send (l_packet, 0)
					end
				end
			end
		rescue
			connection_error := true
			retry
		end

	send_score (a_score: INTEGER)
		-- Send a packet containing `a_score'
		local
			l_size: PACKET
			l_packet: PACKET
		do
			if connection_error then
				close
			else
				create l_size.make (4)
				l_size.data.put_integer_32 (8, 0)
				create l_packet.make (8)
				l_packet.data.put_integer_32 (Score_packet, 0)
				l_packet.data.put_integer_32 (a_score, 4)

				if attached distant_socket as la_socket then
					if la_socket.is_writable and la_socket.is_open_write then
						la_socket.send (l_size, 0)
						la_socket.send (l_packet, 0)
					end
				end
			end
		rescue
			connection_error := true
			retry
		end

	close
		do
			if attached distant_socket as la_socket and then not la_socket.is_closed then
				la_socket.close
			end

			if attached local_socket as la_socket and then not la_socket.is_closed then
				la_socket.close
			end
		end

feature {NONE} -- Implementation

	Enemy_packet: INTEGER = 1
	Player_packet: INTEGER = 2
	Projectile_packet: INTEGER = 3
	Collision_packet: INTEGER = 4
	Score_packet: INTEGER = 5

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 Fran?ois Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
