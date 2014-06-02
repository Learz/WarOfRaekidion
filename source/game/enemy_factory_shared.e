note
	description : "[
					War of Raekidion - An enemy factory implementation
					An {ENEMY_FACTORY_SHARED} initializes an {ENEMY_FACTORY} 
					as a singleton.
				]"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

deferred class
	ENEMY_FACTORY_SHARED

feature {NONE} -- Access

	splash_screen: detachable SPLASH_SCREEN

	enemy_factory: ENEMY_FACTORY
		-- Initialize the {ENEMY_FACTORY} only once
		once
			create result.make (splash_screen)
		end

	set_splash_screen (a_splash: SPLASH_SCREEN)
		do
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 Fran�ois Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
