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
	make

feature -- Access

	quit
		do
			must_quit := true
		end

feature -- Status

	must_quit, is_send_mode, is_recieve_mode: BOOLEAN

feature {NONE} -- Implementation

	execute
		do
			from
				must_quit := false
			until
				must_quit
			loop
				if is_send_mode then

				elseif is_recieve_mode then

				end
			end

		end

end
