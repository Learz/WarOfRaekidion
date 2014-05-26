note
	description : "[
					War of Raekidion - Asynchronous resource loading
					A {RESOURCE_LOAD} thread will ensure every memory expensive 
					resource loading is made before the game starts.
				]"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	RESOURCE_LOAD

inherit
	AUDIO_FACTORY_SHARED
	IMAGE_FACTORY_SHARED
	ENEMY_FACTORY_SHARED
	PROJECTILE_FACTORY_SHARED
	DATABASE_MANAGER_SHARED
	THREAD
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		do
			Precursor {THREAD}
			must_quit := false
		end

feature -- Access

	must_quit: BOOLEAN
		-- True if the thread has loaded all resources

	destroy
		-- Removes all resources from memory
		do
			audio_factory.destroy
			image_factory.destroy
			connexion.destroy
		end

feature {NONE} -- Implementation

	execute
		-- Load every resource available
		local
			l_any: ANY
			l_highscore: HIGHSCORE
		do
			l_any := audio_factory
			l_any := image_factory
			l_any := enemy_factory
			l_any := projectile_factory
			create l_highscore.make
			must_quit := true
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
