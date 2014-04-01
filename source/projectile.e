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
			update,
			manage_collision
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_owner: SHIP)
		do
			owner := a_owner
			entity_make (a_name, a_window, a_x, a_y, 1)
			type := type + ".projectile." + a_owner.out
		end

feature -- Access

	owner: SHIP

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

	manage_collision (a_other: ENTITY)
		do
			if collide_entity (current, a_other, a_other.collision_offset) and a_other /= owner then
				a_other.set_health (a_other.health - 1)
				destroy
			end
		end

end
