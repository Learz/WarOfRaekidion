note
	description: "Summary description for {POWERUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWERUP

inherit
	ENTITY
		rename
			update as entity_update
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_health: INTEGER)
		do
			precursor {ENTITY} (a_name, a_window, a_x, a_y, 1)
			trajectory.enable_degree_mode
		end

feature -- Access

	update (a_x, a_y: DOUBLE)
		do
			if
				y < -height or
				y > (window.height + height) or
				x < -width or
				x > (window.width + width)
			then
				destroy
			end

			if trajectory.force = 0 or previous_force = 0 then
				previous_force := 1
			else
				previous_force := trajectory.force
			end

			trajectory.set_x_and_y (a_x - x, -a_y + y)
			trajectory.set_force (previous_force * 1.05)
			entity_update
		end

feature {NONE} -- Implementation

	previous_force: DOUBLE

end
