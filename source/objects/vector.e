note
	description : "[
						War of Raekidion - A simple 2D vector
						A {VECTOR} stores X and Y coordinates relative to a (0,0) origin, 
						and the angle and distance from the two points (force).
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	VECTOR

inherit
	DOUBLE_MATH
		redefine
			out
		end

create
	make_empty,
	make_from_x_y,
	make_from_angle_force

feature {NONE} -- Initialization

	make_empty
		-- Initialize `Current' to null (0) values
		do
			x := 0
			y := 0
			angle := 0
			force := 0
		end

	make_from_x_y (a_x, a_y: DOUBLE)
		-- Initialize `Current' from `a_x' and `a_y'. Automatically adjust `angle' and `force'
		do
			x := a_x
			y := a_y
			adjust_angle_and_force (a_x, a_y)
		end

	make_from_angle_force (a_angle, a_force: DOUBLE)
		-- Initialize `Current' from `angle' and `force'. Automatically adjust `x' and `y'
		do
			angle := a_angle
			force := a_force
			adjust_x_and_y (a_angle, a_force)
		end

feature -- Access

	x: DOUBLE
		-- x coordinate.

	y: DOUBLE
		-- y coordinate.

	angle: DOUBLE
		-- angle, or direction.

	force: DOUBLE
		-- force, or length.

feature -- Output

	out: STRING_8
		-- Show `x', `y', `angle' and `force' in the console
		do
			result := "x     : " + x.out + "%N" +
					  "y     : " + y.out + "%N" +
					  "angle : " + angle.out + "%N" +
					  "force : " + force.out + "%N"
		end

feature -- Status

	is_degree_mode: BOOLEAN
		-- If this is true, the `angle' will be in degrees

feature -- Element change

	set_x (a_x: DOUBLE)
		-- Assign `x' to `a_x' and adjust `angle' and `force' automatically
		do
			x := a_x
			adjust_angle_and_force (a_x, y)
		end

	set_y (a_y: DOUBLE)
		-- Assign `y' to `a_y' and adjust `angle' and `force' automatically
		do
			y := a_y
			adjust_angle_and_force (x, a_y)
		end

	set_angle (a_angle: DOUBLE)
		-- Assign `angle' to `a_angle' and adjust `x' and `y' automatically
		do
			angle := a_angle
			adjust_x_and_y (a_angle, force)
		end

	set_force (a_force: DOUBLE)
		-- Assign `force' to `a_force' and adjust `x' and `y' automatically
		do
			force := a_force
			adjust_x_and_y (angle, a_force)
		end

	set_x_and_y (a_x, a_y: DOUBLE)
		-- Assign `x' to `a_x' and `y' to `a_y' and adjust `angle' and `force' automatically
		do
			x := a_x
			y := a_y
			adjust_angle_and_force (a_x, a_y)
		end

	set_angle_and_force (a_angle, a_force: DOUBLE)
		-- Assign `angle' to `a_angle' and `force' to `a_force' and adjust `x' and `y' automatically
		do
			angle := a_angle
			force := a_force
			adjust_x_and_y (a_angle, a_force)
		end

	enable_degree_mode
		-- Set `Current' to use degrees instead of radians
		do
			if not is_degree_mode then
				is_degree_mode := true
				angle := degree_value (angle)
			end
		end

	disable_degree_mode
		-- Set `Current' to use radians instead of degrees
		do
			if is_degree_mode then
				is_degree_mode := false
				angle := radian_value (angle)
			end
		end

	plus (a_factor: DOUBLE)
		-- Adds `a_factor' to the current `force' and adjust `x' and `y'
		require
			factor_positive: a_factor > 0
		do
			set_force (force.plus (a_factor))
		end

	plus_vector (a_other: VECTOR)
		-- Adds `a_other' to the current `x' and `y' and adjust `angle' and `force'
		require
			other_exists: a_other /= void
		do
			set_x_and_y (x.plus (a_other.x), y.plus (a_other.y))
		end

	minus (a_factor: DOUBLE)
		-- Removes `a_factor' from the current `force' and adjust `x' and `y'
		require
			factor_positive: a_factor > 0
		do
			set_force (force.minus (a_factor))
		end

	minus_vector (a_other: VECTOR)
		-- Removes `a_other' from the current `x' and `y' and adjust `angle' and `force'
		require
			other_exists: a_other /= void
		do
			set_x_and_y (x.minus (a_other.x), y.minus (a_other.y))
		end

	normalize
		-- Set `force' to 1 and adjust `x' and `y' accordingly
		do
			force := 1
			adjust_x_and_y (angle, 1)
		end

	invert
		-- Swaps the vector around to be pointing in the exact opposite direction
		require
			is_not_zero: x /= 0 and y /= 0
		do
			set_x_and_y (-x, -y)
		end

feature {NONE} -- Implementation

	radian_value (a_degree: DOUBLE): DOUBLE
		-- Convert `a_degree' to radian value
		do
			if is_degree_mode then
				result := pi_div * a_degree
			else
				result := a_degree
			end
		end

	degree_value (a_radian: DOUBLE): DOUBLE
		-- Convert `a_radian' to degree value
		do
			if is_degree_mode then
				result := div_pi * a_radian
			else
				result := a_radian
			end
		end

	pi_div: DOUBLE
		once
			result := pi / 180
		end

	div_pi: DOUBLE
		once
			result := 180 / pi
		end

	x_from_angle_force (a_angle, a_force: DOUBLE): DOUBLE
		-- Find `x' from `a_angle' and `a_force'
		do
			result := -cosine (radian_value (a_angle)) * a_force
		end

	y_from_angle_force (a_angle, a_force: DOUBLE): DOUBLE
		-- Find `y' from `a_angle' and `a_force'
		do
			result := sine (radian_value (a_angle)) * a_force
		end

	angle_from_x_y (a_x, a_y: DOUBLE): DOUBLE
		-- Find `angle' from `a_x' and `a_y'
		do
			if a_x = 0 then
				if a_y = 0 then
					result := angle
				elseif a_y < 0 then
					result := degree_value (pi + pi_2)
				else
					result := degree_value (pi_2)
				end
			else
				if a_x <= 0 and a_y >= 0 then
					result := degree_value (-arc_tangent (a_y / a_x))
				elseif a_x >= 0 and a_y >= 0 then
					result := degree_value (pi - arc_tangent (a_y / a_x))
				elseif a_x >= 0 and a_y <= 0 then
					result := degree_value (pi - arc_tangent (a_y / a_x))
				else
					result := degree_value ((2 * pi) - arc_tangent (a_y / a_x))
				end
			end
		end

	force_from_x_y (a_x, a_y: DOUBLE): DOUBLE
		-- Find `force' from `a_x' and `a_y'
		do
			result := sqrt ((a_x ^ 2) + (a_y ^ 2))
		end

	adjust_x_and_y (a_angle, a_force: DOUBLE)
		-- Assign `angle' and `force' to `a_angle' and `a_force' and adjust `x' and `y' accordingly
		do
			x := x_from_angle_force (a_angle, a_force)
			y := y_from_angle_force (a_angle, a_force)
		end

	adjust_angle_and_force (a_x, a_y: DOUBLE)
		-- Assign `x' and `y' to `a_x' and `a_y' and adjust `angle' and `force' accordingly
		do
			angle := angle_from_x_y (a_x, a_y)
			force := force_from_x_y (a_x, a_y)
		end

end
