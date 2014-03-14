note
	description : "War of Raekidion - {PLAYER_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	PLAYER_SHIP

inherit
	ENTITY
		rename
			make as entity_make
		end

create
	make

feature --Initialisation

	make(a_window:WINDOW; a_x, a_y:INTEGER)
	do
		entity_make ("player", a_window, a_x, a_y)
	end

end
