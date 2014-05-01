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
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_health: DOUBLE)
		do
		    create on_shoot
			precursor {ENTITY} (a_name, a_window, a_x, a_y, a_health)
		end

feature -- Access

	on_shoot: ACTION_SEQUENCE [TUPLE [name: STRING; x, y: INTEGER; angle: DOUBLE; owner: SHIP]]

	destroy
		do
			on_shoot.wipe_out
			precursor {ENTITY}
		end

end
