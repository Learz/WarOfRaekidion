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

	create_interface(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		do
			create_entity(a_name, a_window, a_x, a_y)
		end

end
