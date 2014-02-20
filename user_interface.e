note
	description: "Summary description for {USER_INTERFACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
