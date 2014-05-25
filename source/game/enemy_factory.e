note
	description	: "[
					War of Raekidion - An enemy factory
					An {ENEMY_FACTORY} contains a list of every enemy 
					type able to get spawned in the game screen.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	ENEMY_FACTORY

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_enemy_properties: ENEMY_PROPERTIES
		do
			create file_list.make

		-- TEMPORARY
			create l_enemy_properties.make ("Sprayer", "sprayer", "Sprays bullets in a straight line right onto the player.", "Red laser", 20, 1, 40, 15, 10, 2.5, true)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Mauler", "mauler", "Hauls huge chunks of bullets at you, shotgun-style.", "Blue bullet", 25, 8, 140, 25, 30, 1.5, true)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Homing", "homing", "Shoots homing missiles by pair of two.", "Small missile", 30, 1, 80, 65, 45, 2.0, false)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Laser", "laser", "Fires a deadly bullet ray to burn through your ship.", "Yellow laser", 25, 1, 15, 75, 15, 2.5, true)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Spiral", "spiral", "A ship that does not aim, but shoots in a spiraling pattern.", "Small bomb", 45, 1, 5, 90, {DOUBLE_MATH}.pi, 1.0, false)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
			create l_enemy_properties.make ("Barrage", "barrage", "Fires a huge barrage of deadly bullets towards you.", "Red bullet", 40, 24, 100, 115, 90, 0.5, true)
			file_list.force ([l_enemy_properties.name, l_enemy_properties])
		-- TEMPORARY

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	file_list: LINKED_LIST[TUPLE[name: STRING; object: ENEMY_PROPERTIES]]
		-- The list for all the different loaded enemy properties

	enemy (a_name: STRING): ENEMY_PROPERTIES
		-- Return a loaded enemy type from `a_name'
		local
			l_found: BOOLEAN
		do
			from
				l_found := false
				file_list.start
			until
				l_found or
				file_list.exhausted
			loop
				if file_list.item.name.is_equal (a_name) then
					l_found := true
				end

				file_list.forth
			end

			if l_found then
				file_list.back
				result := file_list.item.object
			else
				create result.make ("", "", "", "", 0, 0, 0, 0, 0, 0, false)
			end
		end

feature {NONE} -- Implementation

	is_init: CELL[BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
