note
	description: "Summary description for {PLAYER_SHIP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
