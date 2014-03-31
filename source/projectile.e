note
	description: "Summary description for {PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECTILE

inherit
	ENTITY
		rename
			make as entity_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_owner: SHIP)
		do
			owner := a_owner
			entity_make (a_name, a_window, a_x, a_y)
		end

feature -- Access

	owner: SHIP

feature -- Status

	is_destroyed: BOOLEAN

feature -- Element change

	destroy
		do
			is_destroyed := true
		end

end
