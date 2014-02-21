note
	description : "War of Raekidion - {USER_INTERFACE} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	USER_INTERFACE

inherit
	ENTITY

create
	create_interface

feature --Initialisation

	create_interface(spritename:STRING;imgwindow:WINDOW;posx,posy:INTEGER)
	do
		create_entity(spritename,imgwindow,posx,posy)
	end

end
