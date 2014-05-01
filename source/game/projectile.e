note
	description: "Summary description for {PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECTILE

inherit
	AUDIO_FACTORY_SHARED
	PROJECTILE_FACTORY_SHARED
	ENTITY
		rename
			make as entity_make,
			update as entity_update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_angle: DOUBLE; a_owner: SHIP)
		do
			projectilefactory := projectile_factory
			projectile_properties := projectilefactory.projectile (a_name)
			owner := a_owner
			play_sound (projectile_properties.sound, -1)
			entity_make (projectile_properties.filename, a_window, a_x, a_y, 1)
			trajectory.enable_degree_mode
			trajectory.set_angle_and_force (a_angle, projectile_properties.speed)
		ensure
			projectile_properties_not_null: projectile_properties.name /= ""
		end

feature -- Access

	projectile_properties: PROJECTILE_PROPERTIES
	owner: SHIP

	update (a_x, a_y: DOUBLE)
		local
			l_vector: VECTOR
		do
			if
				y < 0 or
				y > window.height or
				x < 0 or
				x > window.width - 75
			then
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

end
