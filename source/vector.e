note
	description : "[
						War of Raekidion - A simple 2D vector
						A {VECTOR} stores X and Y coordinates relative to a 
						(0,0) origin, and the angle and distance from the two points (force).
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
	default_create,
	make_from_x_y,
	make_from_angle_force

feature {NONE} -- Initialization

	make_from_x_y (a_x, a_y: DOUBLE)
		-- Initialization of `Current' from `a_x' and `a_y'. Automatically adjust `angle' and `force'
		do
			x := a_x
			y := a_y
			set_angle_and_force (a_x, a_y)
		end

	make_from_angle_force (a_angle, a_force: DOUBLE)
		-- Initialization of `Current' from `angle' and `force'. Automatically adjust `x' and `y'
		do
			angle := a_angle
			force := a_force
			set_x_and_y (a_angle, a_force)
		end

feature -- Access

	x, y, angle, force: DOUBLE

	out: STRING_8
		-- Show `x', `y', `angle' and `force' in the console
		do
			Result := "x     : " + x.out + "%N" +
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
			set_angle_and_force (a_x, y)
		end

	set_y (a_y: DOUBLE)
		-- Assign `y' to `a_y' and adjust `angle' and `force' automatically
		do
			y := a_y
			set_angle_and_force (x, a_y)
		end

	set_angle (a_angle: DOUBLE)
		-- Assign `angle' to `a_angle' and adjust `x' and `y' automatically
		do
			angle := a_angle
			set_x_and_y (a_angle, force)
		end

	set_force (a_force: DOUBLE)
		-- Assign `force' to `a_force' and adjust `x' and `y' automatically
		do
			force := a_force
			set_x_and_y (angle, a_force)
		end

	enable_degree_mode
		-- Set `Current' to use degrees instead of radians
		do
			is_degree_mode := true
			angle := degree_value (angle)
		end

	disable_degree_mode
		-- Set `Current' to use radians instead of degrees
		do
			is_degree_mode := false
			angle := radian_value (angle)
		end

	normalize
		-- Set `force' to 1 and adjust `x' and `y' accordingly
		do
			force := 1
			set_x_and_y (angle, 1)
		end

	set_x_and_y (a_angle, a_force: DOUBLE)
		-- Assing `angle' and `force' to `a_angle' and `a_force' and adjust `x' and `y' accordingly
		do
			x := x_from_angle_force (a_angle, a_force)
			y := y_from_angle_force (a_angle, a_force)
		end

	set_angle_and_force (a_x, a_y: DOUBLE)
		-- Assing `x' and `y' to `a_x' and `a_y' and adjust `angle' and `force' accordingly
		do
			angle := angle_from_x_y (a_x, a_y)
			force := force_from_x_y (a_x, a_y)
		end

feature {NONE} -- Implementation

	radian_value (a_degree: DOUBLE): DOUBLE
		-- Convert `a_degree' to radian value
		do
			if is_degree_mode then
				Result := pi_div * a_degree
			else
				Result := a_degree
			end
		end

	degree_value (a_radian: DOUBLE): DOUBLE
		-- Convert `a_radian' to degree value
		do
			if is_degree_mode then
				Result := div_pi * a_radian
			else
				Result := a_radian
			end
		end

	pi_div: DOUBLE
		once
			Result := pi / 180
		end

	div_pi: DOUBLE
		once
			Result := 180 / pi
		end

	x_from_angle_force (a_angle, a_force: DOUBLE): DOUBLE
		-- Find `x' from `a_angle' and `a_force'
		do
			Result := -cosine (radian_value (a_angle)) * a_force
		end

	y_from_angle_force (a_angle, a_force: DOUBLE): DOUBLE
		-- Find `y' from `a_angle' and `a_force'
		do
			Result := sine (radian_value (a_angle)) * a_force
		end

	angle_from_x_y (a_x, a_y: DOUBLE): DOUBLE
		-- Find `angle' from `a_x' and `a_y'
		do
			if a_x = 0 then
				if a_y = 0 then
					Result := angle
				elseif a_y < 0 then
					Result := degree_value (pi + pi_2)
				else
					Result := degree_value (pi_2)
				end
			else
				if a_x <= 0 and a_y >= 0 then
					Result := degree_value (-arc_tangent (a_y / a_x))
				elseif a_x >= 0 and a_y >= 0 then
					Result := degree_value (pi - arc_tangent (a_y / a_x))
				elseif a_x >= 0 and a_y <= 0 then
					Result := degree_value (pi - arc_tangent (a_y / a_x))
				else
					Result := degree_value ((2 * pi) - arc_tangent (a_y / a_x))
				end
			end
		end

	force_from_x_y (a_x, a_y: DOUBLE): DOUBLE
		-- Find `force' from `a_x' and `a_y'
		do
			Result := sqrt ((a_x ^ 2) + (a_y ^ 2))
		end

end
