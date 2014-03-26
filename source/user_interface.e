note
	description : "War of Raekidion - {USER_INTERFACE} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	USER_INTERFACE

inherit
	SPRITE
		rename
			make as sprite_make
		end

create
	make

feature --Initialisation

	make(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		do
			sprite_make(a_name, a_window, a_x, a_y)
		end

end
