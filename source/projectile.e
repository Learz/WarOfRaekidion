note
	description: "Summary description for {PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECTILE

inherit
	ENTITY
		rename
			make as entity_make
		end

create
	make

feature

	speed:INTEGER

	make(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		do
			entity_make (a_name, a_window, a_x, a_y)
			speed:=1
		end

	set_speed(a_speed:INTEGER)
		do
			speed:=a_speed
		end

end
