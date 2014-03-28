note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENEMY_SHIP

inherit
	SHIP
		redefine
			make,
			update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			if a_name.is_equal ("enemy_red") then
				bullet_type := "bullet_red"
				bullet_angle := {DOUBLE_MATH}.pi_4
				bullet_force := 0.1
			elseif a_name.is_equal ("enemy_yellow") then
				bullet_type := "bullet_red"
				bullet_angle := {DOUBLE_MATH}.pi_2
				bullet_force := 0.2
			elseif a_name.is_equal ("enemy_black") then
				bullet_type := "bullet_red"
				bullet_angle := {DOUBLE_MATH}.pi
				bullet_force := 0.4
			else
				bullet_type := "bullet_red"
				bullet_angle := 0 + 90
				bullet_force := 0.8
			end

			Precursor {SHIP} (a_name, a_window, a_x, a_y)
		end

feature -- Access

	update
		local
			l_projectile: PROJECTILE
		do
			projectile_delay := (projectile_delay + 1) \\ 20

			if projectile_delay = 0 then
				l_projectile := create {PROJECTILE}.make (bullet_type, window, x + (width / 2).floor - 4, y + (height / 2).floor - 4)
				l_projectile.trajectory.enable_degree_mode
				l_projectile.trajectory.set_angle (lifetime * bullet_angle)
				l_projectile.trajectory.set_force (bullet_force)
				projectile_list.extend (l_projectile)
			end

			Precursor {SHIP}
		end

feature {NONE} -- Implementation

	bullet_type: STRING
	bullet_angle, bullet_force: DOUBLE
	create_projectile: BOOLEAN
	projectile_delay: INTEGER

end
