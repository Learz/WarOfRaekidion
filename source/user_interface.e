note
	description : "War of Raekidion - {USER_INTERFACE} class"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	USER_INTERFACE

inherit
	ENTITY
		rename
			make as entity_make
		end

create
	make

feature --Initialisation

	make(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		do
			entity_make(a_name, a_window, a_x, a_y)
		end

end
