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
			make as entity_make
		redefine
			update
		end
	COLLISION

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_health: NATURAL_16)
		do
			health := a_health
		    create projectile_list.make
		    create on_collision
			entity_make (a_name, a_window, a_x, a_y)
		end

feature -- Access

	health: NATURAL_16
	projectile_list: LINKED_LIST[PROJECTILE]
	on_collision: ACTION_SEQUENCE [TUPLE [a_other: SHIP]]

	update
		do
			if health <= 0 then
				destroy
			end

			from
				projectile_list.start
			until
				projectile_list.exhausted
			loop
				if
					projectile_list.item.y < -projectile_list.item.height or
					projectile_list.item.y > (window.height + projectile_list.item.height) or
					projectile_list.item.x < -projectile_list.item.width or
					projectile_list.item.x > (window.width + projectile_list.item.width) or
					projectile_list.item.is_destroyed
				then
					projectile_list.remove
				else
					projectile_list.item.update
				end

				if not projectile_list.exhausted then
					projectile_list.forth
				end
			end

			on_collision.call (current)

			precursor {ENTITY}
		end

	manage_collision (a_other: SHIP)
		do
			from
				a_other.projectile_list.start
			until
				a_other.projectile_list.exhausted
			loop
				if collide_entity (a_other.projectile_list.item, current, 0) then
					a_other.projectile_list.item.destroy
					set_health (health - 1)
				end
				a_other.projectile_list.forth
			end
		end

	destroy
		do
			dispose
		end

feature -- Element change

	set_health (a_health: NATURAL_16)
		do
			health := a_health
		end

end
