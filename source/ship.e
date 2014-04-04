note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	SHIP

inherit
	ENTITY
		redefine
			make,
			update,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_health: NATURAL_16)
		do
			precursor {ENTITY} (a_name, a_window, a_x, a_y, a_health)
		end

feature -- Access

	update
		do
			precursor {ENTITY}
		end

	destroy
		do
			precursor {ENTITY}
		end

end
