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

			if attached enemy_properties as la_enemy then
				ship_make (la_enemy.name, a_window, a_x, a_y, la_enemy.health)
				bullet_type := la_enemy.bullet
				bullet_count := la_enemy.count
				ship_speed := la_enemy.speed
				bullet_spread := la_enemy.spread
				bullet_firerate := la_enemy.firerate
			else
				ship_make ("", a_window, a_x, a_y, 0)
				bullet_type := ""
				bullet_count := 0
				ship_speed := 0
				bullet_spread := 0
				bullet_firerate := 0
			end
		end

feature -- Access

	id: INTEGER

	update (a_x, a_y: DOUBLE)
		local
			l_projectile: PROJECTILE
		do
			l_projectile := create {PROJECTILE}.make (bullet_type, window, x + (width / 2).floor, y + (height / 2).floor, false)
			l_projectile.trajectory.enable_degree_mode
			l_projectile.trajectory.set_x_and_y (a_x, a_y)
			l_projectile.trajectory.set_force (3)
			on_shoot.call (l_projectile)
			ship_update
		end

feature {NONE} -- Implementation

	enemyfactory: ENEMY_FACTORY
	enemy_properties: detachable ENEMY_PROPERTIES
	ship_speed: DOUBLE
	bullet_type: STRING
	bullet_count: INTEGER
	bullet_spread: DOUBLE
	bullet_firerate: DOUBLE
	create_projectile: BOOLEAN

end
