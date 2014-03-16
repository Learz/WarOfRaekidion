note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ENEMY_SHIP

inherit
	ENTITY
		rename
			make as entity_make,
			update as entity_update
		end

create
	make

feature {NONE} -- Initialization

	projectile_list: LINKED_LIST[PROJECTILE]
	create_projectile: BOOLEAN
	projectile_delay: INTEGER

	make(a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
		    create projectile_list.make
			entity_make (a_name, a_window, a_x, a_y)
		end

feature

	update
		local
			l_projectile: PROJECTILE
		do
			--if create_projectile then
				projectile_delay := (projectile_delay + 1) \\ 20

				if projectile_delay = 0 then
					l_projectile := create {PROJECTILE}.make ("sbullet", window, x + (width / 2).floor - 8, y + (height / 2).floor - 8)
					l_projectile.trajectory.set_to_degrees
					l_projectile.trajectory.define_position_from_angle_force (lifetime * 8.1, 0.2)
					projectile_list.extend (l_projectile)
				end
			--end

			from
				projectile_list.start
			until
				projectile_list.exhausted
			loop
				if
					projectile_list.item.y < -projectile_list.item.height or
					projectile_list.item.y > (window.height + projectile_list.item.height) or
					projectile_list.item.x < -projectile_list.item.width or
					projectile_list.item.x > (window.width + projectile_list.item.width)
				then
					projectile_list.remove
				else
					projectile_list.item.update
				end

				if not projectile_list.exhausted then
					projectile_list.forth
				end
			end

			entity_update
		end

	start_shooting
		do
			create_projectile := true
		end

	stop_shooting
		do
			create_projectile := false
		end

end
