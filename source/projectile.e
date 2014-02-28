note
	description: "Summary description for {PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECTILE

inherit
	ENTITY

create
	create_projectile

feature

	speed:DOUBLE

	create_projectile(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		do
			create_entity(a_name, a_window, a_x, a_y)
			speed:=1
		end

	set_speed(set:DOUBLE)
		do
			speed:=set
		end

end
