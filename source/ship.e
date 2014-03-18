note
	description : "War of Raekidion - {ENEMY_SHIP} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	SHIP

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

	make(a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		do
		    create projectile_list.make
			entity_make (a_name, a_window, a_x, a_y)
		end

feature

	update
		do
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

end
