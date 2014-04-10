note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENEMY_SHIP

inherit
	SHIP
		rename
			make as ship_make
		redefine
			update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			if a_name.is_equal ("enemy_red") then
				bullet_type := "laser_red"
				bullet_angle := {DOUBLE_MATH}.pi_4 * 10
				bullet_firerate := 2
				bullet_force := 1
			elseif a_name.is_equal ("enemy_yellow") then
				bullet_type := "laser_yellow"
				bullet_angle := -{DOUBLE_MATH}.pi_2 * 10
				bullet_firerate := 4
				bullet_force := 1
			elseif a_name.is_equal ("enemy_black") then
				bullet_type := "laser_white"
				bullet_angle := {DOUBLE_MATH}.pi * 10
				bullet_firerate := 1
				bullet_force := 1
			else
				bullet_type := "laser_red"
				bullet_angle := 0 + 90
				bullet_firerate := 10
				bullet_force := 2
			end

			ship_make (a_name, a_window, a_x, a_y, 100)
		end

feature -- Access

	update
		local
			l_projectile: PROJECTILE
		do
			projectile_delay := (projectile_delay + 1) \\ bullet_firerate

			if projectile_delay = 0 then
				l_projectile := create {PROJECTILE}.make (bullet_type, window, x + (width / 2).floor, y + (height / 2).floor, false)
				l_projectile.trajectory.enable_degree_mode
				l_projectile.trajectory.set_angle (lifetime * bullet_angle)
				l_projectile.trajectory.set_force (bullet_force)
				on_shoot.call (l_projectile)
			end

			precursor {SHIP}
		end

feature {NONE} -- Implementation

	bullet_type: STRING
	bullet_angle, bullet_force: DOUBLE
	bullet_firerate: NATURAL_8
	create_projectile: BOOLEAN
	projectile_delay: NATURAL_8

end
