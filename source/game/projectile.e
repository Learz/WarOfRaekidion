note
	description: "Summary description for {PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECTILE

inherit
	PROJECTILE_FACTORY_SHARED
	ENTITY
		rename
			make as entity_make
		redefine
			update
		end
	AUDIO_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_angle: DOUBLE; a_owner: BOOLEAN)
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
	owner: BOOLEAN

	update
		do
			if
				y < -height or
				y > (window.height + height) or
				x < -width or
				x > (window.width + width)
			then
				destroy
			end

			angle := trajectory.angle - 90
			precursor {ENTITY}
		end

feature {NONE} -- Implementation

	projectilefactory: PROJECTILE_FACTORY

end
