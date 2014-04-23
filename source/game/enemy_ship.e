note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENEMY_SHIP

inherit
	ENEMY_FACTORY_SHARED
	SHIP
		rename
			make as ship_make,
			update as ship_update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
			enemyfactory := enemy_factory
			enemy_properties := enemyfactory.enemy (a_name)
			check is_enem_valid: enemy_properties.name /= "" end
			ship_make (enemy_properties.filename, a_window, a_x, a_y, enemy_properties.health)
		ensure
			enemy_properties_not_null: enemy_properties.name /= ""
		end

feature -- Access

	id: INTEGER

	update (a_x, a_y: DOUBLE)
		local
			l_projectile: PROJECTILE
		do
			if lifetime // 20 = 0 then
				l_projectile := create {PROJECTILE}.make (enemy_properties.bullet, window, x + (width / 2).floor, y + (height / 2).floor, 0, false)
				l_projectile.trajectory.enable_degree_mode
				l_projectile.trajectory.set_x_and_y (a_x, a_y)
				on_shoot.call (l_projectile)
			end
			
			ship_update
		end

feature {NONE} -- Implementation

	enemyfactory: ENEMY_FACTORY
	enemy_properties: ENEMY_PROPERTIES
	create_projectile: BOOLEAN

end
