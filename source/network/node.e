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

	recieve_player_position: TUPLE [INTEGER, INTEGER]
		local
			l_x, l_y: INTEGER
		do
			socket.read_integer
			l_x := socket.last_integer
			socket.read_integer
			l_y := socket.last_integer
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
			result := [l_name, l_x, l_y]
		end

	send_player_position (a_x, a_y: INTEGER)
		do
			socket.put_integer (a_x)
			socket.put_integer (a_y)
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
	socket: NETWORK_DATAGRAM_SOCKET

end
