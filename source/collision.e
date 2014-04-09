note
	description: "Summary description for {COLLISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COLLISION

feature -- Access

	offset: INTEGER_16 deferred end
	width: INTEGER_16 deferred end
	x: DOUBLE deferred end
	y: DOUBLE deferred end

	has_collided (a_other: COLLISION): BOOLEAN
		local
			l_x_difference, l_y_difference: DOUBLE
			l_center_distance_squared, l_radius_sum_squared: INTEGER_32
		do
			l_x_difference := a_other.x - x
			l_y_difference := a_other.y - y
			l_center_distance_squared := ((l_x_difference ^ 2) + (l_y_difference ^ 2)).floor
			l_radius_sum_squared := ((a_other.width + width) ^ 2).floor
			result := (l_center_distance_squared - l_radius_sum_squared) <= offset
		end

end
