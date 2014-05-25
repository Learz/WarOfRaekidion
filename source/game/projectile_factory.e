note
	description	: "[
					War of Raekidion - A projectile factory
					A {PROJECTILE_FACTORY} contains a list of every  
					projectile type able to get spawned in the game screen.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	PROJECTILE_FACTORY

create
	make

feature {NONE} -- Initialization

	make
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_projectile_properties: PROJECTILE_PROPERTIES
		do
			create file_list.make

		-- TEMPORARY
			create l_projectile_properties.make ("White laser", "white_laser", "laser1", 3.0, 6.5, false, -1, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Red laser", "red_laser", "laser3", 1.0, 3.0, false, -1, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Blue bullet", "blue_bullet", "hit", 0.5, 2.0, false, -1, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Small missile", "small_missile", "missile", 5.0, 0.75, true, 5, true)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Yellow laser", "yellow_laser", "laser2", 1.0, 5.0, false, -1, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Small bomb", "small_bomb", "hit", 2.0, 0.5, false, -1, true)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
			create l_projectile_properties.make ("Red bullet", "red_bullet", "hit", 0.5, 1.5, false, -1, false)
			file_list.force ([l_projectile_properties.name, l_projectile_properties])
		-- TEMPORARY

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	projectile (a_name: STRING): PROJECTILE_PROPERTIES
		-- Return a loaded projectile type from `a_name'
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
				create result.make ("", "", "", 0, 0, false, 0, false)
			end
		end

feature {NONE} -- Implementation

	file_list: LINKED_LIST[TUPLE[name: STRING; object: PROJECTILE_PROPERTIES]]
		-- The list for all the different loaded projectile properties

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
