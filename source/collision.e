note
	description: "Summary description for {COLLISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COLLISION

feature -- Access

	collision_offset: INTEGER_32

	collide_circle (a_x_1, a_y_1, a_radius_1, a_x_2, a_y_2, a_radius_2, a_offset: INTEGER_32): BOOLEAN
		local
			l_x_difference, l_y_difference: INTEGER_32
			l_center_distance_squared, l_radius_sum_squared: INTEGER_32
		do
			l_x_difference := a_x_2 - a_x_1
			l_y_difference := a_y_2 - a_y_1
			l_center_distance_squared := ((l_x_difference ^ 2) + (l_y_difference ^ 2)).floor
			l_radius_sum_squared := ((a_radius_1 + a_radius_2) ^ 2).floor
			if a_offset < 0 then
				result := (l_center_distance_squared - l_radius_sum_squared) <= -(a_offset ^ 2)
			else
				result := (l_center_distance_squared - l_radius_sum_squared) <= (a_offset ^ 2)
			end
		end

	collide_entity (a_entity_1, a_entity_2: ENTITY; a_offset: INTEGER_32): BOOLEAN
		do
			result := collide_circle (a_entity_1.x.floor + (a_entity_1.width / 2).floor, a_entity_1.y.floor + (a_entity_1.width / 2).floor, (a_entity_1.width / 2).floor, a_entity_2.x.floor + (a_entity_2.width / 2).floor, a_entity_2.y.floor + (a_entity_2.width / 2).floor, (a_entity_2.width / 2).floor, a_offset)
		end

end
