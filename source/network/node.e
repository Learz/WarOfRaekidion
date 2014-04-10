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
				l_x := l_packet.data.read_integer_32 (0)
				l_y := l_packet.data.read_integer_32 (32)
			end
			result := [l_x, l_y]
		end

	recieve_new_enemy_ship: TUPLE [STRING, INTEGER, INTEGER]
		local
			l_name_count: INTEGER
			l_name: STRING
			l_x, l_y: INTEGER
		do
			socket.read_integer
			l_name_count := socket.last_integer
			socket.read_stream (l_name_count)
			l_name := socket.last_string
			socket.read_integer
			l_x := socket.last_integer
			socket.read_integer
			l_y := socket.last_integer
			io.put_integer (l_x)
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
		do
			socket.put_integer (a_name.count)
			socket.put_string (a_name)
			socket.put_integer (a_x)
			socket.put_integer (a_y)
		end

feature {NONE} -- Implementation

	host: STRING
	port: INTEGER

end
