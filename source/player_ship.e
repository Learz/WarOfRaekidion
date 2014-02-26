note
	description : "War of Raekidion - {PLAYER_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	PLAYER_SHIP

inherit
	ENTITY

create
	create_ship

feature --Initialisation

	create_ship(a_window:WINDOW; a_x, a_y:INTEGER)
	do
		create_entity("player", a_window, a_x, a_y)
	end

end
