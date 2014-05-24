note
	description	: "[
					War of Raekidion - A collidable object
					A {COLLISION} is an entity capable of reacting to 
					being in the same space as another collidable object.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

deferred class
	COLLISION

feature -- Access

	offset: INTEGER deferred end
		-- The radius to add to the real `Current''s radius

	width: INTEGER deferred end
		-- Width of `Current'

	height: INTEGER deferred end
		-- Height of `Current'

	x: DOUBLE deferred end
		-- x position of `Current'

	y: DOUBLE deferred end
		-- y position of `Current'

	has_collided (a_other: COLLISION): BOOLEAN
		-- Has current's bounding area collided with another {COLLISION}
		local
			l_x_difference, l_y_difference: DOUBLE
			l_center_distance_squared, l_radius_sum_squared: DOUBLE
			l_first_offset_squared, l_second_offset_squared: DOUBLE
		do
			l_x_difference := a_other.x - x
			l_y_difference := a_other.y - y
			l_center_distance_squared := (l_x_difference ^ 2) + (l_y_difference ^ 2)
			l_radius_sum_squared := ((a_other.width / 2) + (width / 2)) ^ 2

			if a_other.offset >= 0 then
				l_first_offset_squared := (a_other.offset ^ 2)
			else
				l_first_offset_squared := -(a_other.offset ^ 2)
			end

			if offset >= 0 then
				l_second_offset_squared := (offset ^ 2)
			else
				l_second_offset_squared := -(offset ^ 2)
			end

			result := l_center_distance_squared - l_radius_sum_squared <= l_first_offset_squared - l_second_offset_squared
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
