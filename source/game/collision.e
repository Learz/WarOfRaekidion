note
	description: "Summary description for {COLLISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COLLISION

feature -- Access

	offset: INTEGER deferred end
	width: INTEGER deferred end
	height: INTEGER deferred end
	x: DOUBLE deferred end
	y: DOUBLE deferred end

	has_collided (a_other: COLLISION): BOOLEAN
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

end
