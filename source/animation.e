note
	description : "War of Raekidion - {ANIMATION} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date: "$Date$"
	revision: "$Revision$"

class
	ANIMATION

inherit
	THREAD

create
	make

feature

	quit
		do
			must_quit:=true
		end

feature {NONE}

	must_quit:BOOLEAN

	execute
		do
			from
				must_quit:=False
			until
				must_quit
			loop
				print("allo ")
			end

		end

end
