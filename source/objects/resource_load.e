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
		redefine
			set_splash_screen,
			splash_screen
		end
	IMAGE_FACTORY_SHARED
		redefine
			set_splash_screen,
			splash_screen
		end
	ENEMY_FACTORY_SHARED
		redefine
			set_splash_screen,
			splash_screen
		end
	PROJECTILE_FACTORY_SHARED
		redefine
			set_splash_screen,
			splash_screen
		end
	DATABASE_MANAGER_SHARED
	THREAD
		rename
			make as thread_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_splash: SPLASH_SCREEN)
		-- Initialize `Current' from `a_splash'
		do
			thread_make
			set_splash_screen (a_splash)
			must_quit := false
		end

feature -- Status

	cheat_mode: BOOLEAN
		-- True if mods have been added or base files have been modified

	must_quit: BOOLEAN
		-- True if the thread has loaded all resources

feature -- Access

	destroy
		-- Removes all resources from memory
		do
			audio_factory.destroy
			image_factory.destroy
			connexion.destroy
		end

feature {NONE} -- Implementation

	splash_screen: detachable SPLASH_SCREEN

	set_splash_screen (a_splash: SPLASH_SCREEN)
		do
			splash_screen := a_splash
		end

	execute
		-- Load every resource available
		local
			l_loading: LOADING
			l_highscore: HIGHSCORE
		do
			l_loading := audio_factory
			l_loading := image_factory
			l_loading := enemy_factory

			if l_loading.cheat_mode then
				cheat_mode := true
			end

			l_loading := projectile_factory

			if l_loading.cheat_mode then
				cheat_mode := true
			end

			create l_highscore.make

			if attached splash_screen as la_screen then
				la_screen.change_message ("Loading complete.")
			end

			must_quit := true
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
