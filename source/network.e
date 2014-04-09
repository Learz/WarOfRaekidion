note
	description : "War of Raekidion - {NETWORK} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date: "$Date$"
	revision: "$Revision$"

class
	NETWORK

inherit
	THREAD
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			precursor {THREAD}
			host := ""
			create socket.make_bound (0)
		end

feature -- Access

	quit
		do
			must_quit := true
			join
			socket.close
		end

feature -- Status

	must_quit, reception_mode: BOOLEAN

feature -- Element change

	launch_client (a_address: STRING; a_port: INTEGER)
		do
			quit
			host := a_address
			port := a_port
			create socket.make_targeted (host, port)
			reception_mode := false
			launch
		end

	launch_server (a_port: INTEGER)
		do
			quit
			port := a_port
			create socket.make_bound (port)
			reception_mode := true
			launch
		end

feature {NONE} -- Implementation

	host: STRING
	port: INTEGER
	socket: NETWORK_DATAGRAM_SOCKET

	execute
		local
			number: INTEGER
		do
			from
				must_quit := false
			until
				must_quit
			loop
				if reception_mode then
					socket.read_integer
					number := number + socket.last_integer
					io.put_string (number.out + " ")
				else
					number := number + 1
					socket.put_integer (number)
				end
			end

		end

end
