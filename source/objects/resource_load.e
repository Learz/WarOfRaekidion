note
	description : "[
					War of Raekidion - Asynchronous resource loading
					A {RESOURCE_LOAD} thread will ensure every memory expensive 
					resource loading is made before the game starts.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
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
			execute
		end

feature -- Access

	must_quit: BOOLEAN
		-- True if the thread has loaded all resources

feature {NONE} -- Implementation

	execute
		-- Load every resource available
		local
			l_any: ANY
		do
			l_any := audio_factory
			l_any := image_factory
			l_any := enemy_factory
			l_any := projectile_factory
			l_any := connexion
			must_quit := true
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
