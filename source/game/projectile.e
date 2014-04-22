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
		redefine
			update
		end
	AUDIO_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_owner: BOOLEAN)
		do
			owner := a_owner
			play_sound ("laser", -1)
			entity_make (a_name, a_window, a_x, a_y, 1)
		end

feature -- Access

	owner: BOOLEAN

	update
		do
			if
				y < -height or
				y > (window.height + height) or
				x < -width or
				x > (window.width + width)
			then
				destroy
			end

			angle := trajectory.angle - 90
			precursor {ENTITY}
		end

end
