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
			make as entity_make,
			update as entity_update
		end

create
	make

feature {NONE} -- Initialisation

	make (a_name:STRING; a_window:WINDOW; a_x, a_y: DOUBLE)
		do
			entity_make (a_name, a_window, a_x, a_y)
		end

feature

	update
		do
			entity_update
		end

end
