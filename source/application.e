note
	description : "War of Raekidion - {APPLICATION} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	APPLICATION

inherit
	SDL_WRAPPER
	IMAGE_FACTORY_SHARED

create
	make

feature {NONE} -- Initialisation

	make
		--Démarrer l'application
		local
			l_imagefactory:IMAGE_FACTORY
			l_window:WINDOW
			l_shouldquit:BOOLEAN
			l_player:PLAYER_SHIP
			l_sidebar:USER_INTERFACE
			l_event:EVENT_HANDLER
			l_thistime, l_lasttime, l_stoptime:INTEGER
			l_deltatime:REAL_64
			l_speed, l_directionx, l_directiony:DOUBLE

		do
			l_shouldquit := false
			l_stoptime := 0
			l_speed := 2

			-- Initialisation de la fenêtre, des images et de leurs conteneurs
		    l_window := create {WINDOW}.create_window ("War of Raekidion", sdl_windowpos_undefined, sdl_windowpos_undefined, 500, 600, 0)
		    l_player := create {PLAYER_SHIP}.create_ship (l_window, 0, 200)
		    l_sidebar := create {USER_INTERFACE}.create_interface ("sidebar", l_window, l_window.width - 100, 0)

			l_event := create {EVENT_HANDLER}.create_event_handler;

			--Boucle d'exécution du jeu
			from
			until
				l_shouldquit
			loop
				sdl_pollevent_noreturn (l_event.event)

				if l_event.is_quit_event then
					l_shouldquit := true
				end

				l_thistime := sdl_getticks.to_integer_32

				if l_event.is_mouse_down then
					l_stoptime := l_stoptime + l_thistime - l_lasttime
				end

				l_event.get_key_pressed

				if l_event.is_key_down then
					if l_event.is_key_w then
						l_directiony := -1
					end
					if l_event.is_key_a then
						l_directionx := -1
					end
					if l_event.is_key_s then
						l_directiony := 1
					end
					if l_event.is_key_d then
						l_directionx := 1
					end
					if l_event.is_key_lshift then
						l_speed := 1
					end
				end

				if l_event.is_key_up then
					if l_event.is_key_w and l_directiony < 0 then
						l_directiony := 0
					end
					if l_event.is_key_a and l_directionx < 0 then
						l_directionx := 0
					end
					if l_event.is_key_s and l_directiony > 0 then
						l_directiony := 0
					end
					if l_event.is_key_d and l_directionx > 0 then
						l_directionx := 0
					end
					if l_event.is_key_lshift then
						l_speed := 2
					end
				end

				l_deltatime := l_thistime - l_lasttime
				l_lasttime := l_thistime

			    --Try to move the entities
			    l_player.set_x (l_player.get_x + (l_directionx * l_speed))
			    l_player.set_y (l_player.get_y + (l_directiony * l_speed))

	    		--Frame render
			    l_window.render_clear
			    l_player.update_entity
			    l_sidebar.update_entity
			    l_window.render_window

			    --Delay
			    sdl_delay(8)
			end

			l_imagefactory := factory

		    --Fermeture de la fenêtre et des entités
		    l_player.destroy_entity
		    l_sidebar.destroy_entity
		    l_window.destroy_window
		    l_event.destroy_event_handler
		    l_imagefactory.destroy_images
		    sdl_quit

		end

end
