note
	description	: "[
					War of Raekidion - A projectile
					A {PROJECTILE} is a bullet fired by a ship, 
					aimed to destroy other ships.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	PROJECTILE

inherit
	PROJECTILE_FACTORY_SHARED
		rename
			set_splash_screen as set_projectile_splash_screen,
			splash_screen as projectile_splash_screen
		end
	ENTITY
		rename
			make as entity_make,
			update as entity_update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_angle: DOUBLE; a_owner: SHIP)
		-- Initialize `Current' from `a_name', `a_window', `a_x', `a_y', `a_angle' and `a_owner'
		do
			projectilefactory := projectile_factory
			projectile_properties := projectilefactory.projectile (a_name)
			owner := a_owner
			entity_make (projectile_properties.filename, a_window, a_x, a_y, 1, 1)
			will_explode := true
			trajectory.enable_degree_mode
			trajectory.set_angle_and_force (a_angle, projectile_properties.speed)
		ensure
			projectile_properties_not_null: projectile_properties.name /= ""
				-- Ensure the projectile type exists
		end

feature -- Status

	will_explode: BOOLEAN
		-- True if the projectile should explode on impact

feature -- Access

	projectile_properties: PROJECTILE_PROPERTIES
		-- The projectile type from which the projectile will be created

	owner: SHIP
		-- The ship from which the bullet has been fired

	update (a_x, a_y: DOUBLE)
		-- Update the enemy on screen from player's `a_x' and `a_y'
		local
			l_vector: VECTOR
		do
			if
				y < -height or
				y > window.height + height or
				x < -width or
				x > window.width - 75 + width
			then
				will_explode := false
				destroy
			end

			if projectile_properties.lifetime > 0 and then lifetime >= projectile_properties.lifetime * 100 then
				destroy
			end

			if projectile_properties.homing then
				l_vector := trajectory
				trajectory.set_x_and_y (a_x - x, -a_y + y)
				trajectory.set_force (projectile_properties.speed)
				trajectory.plus_vector (l_vector)
				trajectory.set_force (projectile_properties.speed)
			end

			angle := trajectory.angle - 90
			entity_update
		end

feature {NONE} -- Implementation

	projectilefactory: PROJECTILE_FACTORY
		-- The factory containing the projectile types

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
