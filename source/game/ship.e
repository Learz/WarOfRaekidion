note
	description	: "[
					War of Raekidion - A spaceship
					A {SHIP} is an entity with a shoot event.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	SHIP

inherit
	ENTITY
		redefine
			make,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y, a_health: DOUBLE; a_lives: INTEGER)
		-- Initialize `Current' from `a_name', `a_window', `a_x', `a_y', `a_health' and `a_lives'
		do
		    create on_shoot
			precursor {ENTITY} (a_name, a_window, a_x, a_y, a_health, a_lives)
		end

feature -- Access

	on_shoot: ACTION_SEQUENCE [TUPLE [name: STRING; x, y: INTEGER; angle: DOUBLE; owner: SHIP]]
		-- The list of shooting events

	destroy
		-- Destroy the ship
		do
			on_shoot.wipe_out
			precursor {ENTITY}
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
