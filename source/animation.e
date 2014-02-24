note
	description: "Summary description for {CHEVAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHEVAL

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
