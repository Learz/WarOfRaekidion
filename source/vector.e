note
	description : "War of Raekidion - A VECTOR stores X and Y coordinates relative to a (0,0) origin, and the angle and distance from the two points (force)."
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	VECTOR

inherit
	DOUBLE_MATH

create
	make_default,
	make_from_x_y,
	make_from_angle_force

feature {NONE} -- Initialization

	make_default
		-- Initialization of the vector with default values (0).
		do
			create position.default_create
			degrees_mode := false
			define_position (0, 0, 0, 0)
		end

	make_from_x_y (a_x, a_y: DOUBLE)
		-- Initialization of the vector from its X an Y values. Automatically sets the angle and force of the vector from the X and Y values.
		do
			create position.default_create
			degrees_mode := false
			define_position_from_x_y (a_x, a_y)
		end

	make_from_angle_force (a_angle, a_force: DOUBLE)
		-- Initialization of the vector from its angle and force. Automatically sets the X an Y values from the angle and force of the vector.
		do
			create position.default_create
			degrees_mode := false
			define_position_from_angle_force (a_angle, a_force)
		end

feature -- Access

	position: TUPLE [x, y, angle, force: DOUBLE]

	degrees_to_radians: DOUBLE
		-- If necessary, convert degress to radians.
		do
			if degrees_mode then
				Result := pi / 180
			else
				Result := 1
			end
		end

	radians_to_degrees: DOUBLE
		-- If necessary, convert radians to degrees.
		do
			if degrees_mode then
				Result := 180 / pi
			else
				Result := 1
			end
		end

	x_from_angle_force (a_angle, a_force: DOUBLE): DOUBLE
		-- Find X value from angle and force of the vector.
		do
			Result := cosine (a_angle * degrees_to_radians) * a_force
		end

	y_from_angle_force (a_angle, a_force: DOUBLE): DOUBLE
		-- Find Y value from angle and force of the vector.
		do
			Result := sine (a_angle * degrees_to_radians) * a_force
		end

	angle_from_x_y (a_x, a_y: DOUBLE): DOUBLE
		-- Find angle of the vector from X and Y values.
		do
			Result := arc_tangent (a_y / a_x) * radians_to_degrees
		end

	force_from_x_y (a_x, a_y: DOUBLE): DOUBLE
		-- Find force of the vector from X and Y values.
		do
			Result := sqrt ((a_x ^ 2) + (a_y ^ 2))
		end

feature -- Status

	degrees_mode: BOOLEAN

feature -- Element change

	set_to_degrees
		-- Set this object to use degrees instead of radians.
		do
			degrees_mode := true
		end

	normalize
		-- Reset force to 1 and change X and Y accordingly
		require
			not position.is_empty
		do
			position.put (x_from_angle_force (position.angle, 1), 1)
			position.put (y_from_angle_force (position.angle, 1), 2)
			position.put (1, 4)
		end

	define_position (a_x, a_y, a_angle, a_force: DOUBLE)
		-- Set the vector properties manually.
		do
			position.put (a_x, 1)
			position.put (a_y, 2)
			position.put (a_angle, 3)
			position.put (a_force, 4)
		end

	define_position_from_angle_force (a_angle, a_force: DOUBLE)
		-- Set the vector properties by angle and force.
		do
			define_position (x_from_angle_force (a_angle, a_force), y_from_angle_force (a_angle, a_force), a_angle, a_force)
		end

	define_position_from_x_y (a_x, a_y: DOUBLE)
		-- Set the vector properties by X and Y.
		do
			define_position (a_x, a_y, angle_from_x_y (a_x, a_y), force_from_x_y (a_x, a_y))
		end

end
