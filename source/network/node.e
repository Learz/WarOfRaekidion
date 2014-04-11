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
		do
			host := a_address
			port := a_port
			create socket.make_targeted (host, port)
		end

	make_server (a_port: INTEGER)
		do
			host := ""
			port := a_port
			create socket.make_bound (port)
		end

feature -- Access

	socket: NETWORK_DATAGRAM_SOCKET

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

feature {NONE} -- Implementation

	host: STRING
	port: INTEGER

end
