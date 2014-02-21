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

	create_ship(imgwindow:WINDOW;posx,posy:INTEGER)
	do
		create_entity("ship",imgwindow,posx,posy)
	end

end
