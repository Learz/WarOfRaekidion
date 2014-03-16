note
	description : "War of Raekidion - {APPLICATION} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialisation

	make
		--Démarrer l'application
		local
			l_window:WINDOW
			l_shouldquit:BOOLEAN
			l_player:PLAYER_SHIP
			l_enemy:ENEMY_SHIP
			l_sidebar:USER_INTERFACE
			l_event:EVENT_HANDLER
			l_thistime, l_lasttime, l_stoptime:INTEGER
			l_deltatime:REAL_64
			l_speed, l_directionx, l_directiony:INTEGER
		do
			l_shouldquit := false
			l_stoptime := 0
			l_speed := 2
			-- Initialisation de la fenêtre, des images et de leurs conteneurs
		    create l_window.make ("War of Raekidion", {SDL_WRAPPER}.sdl_windowpos_undefined, {SDL_WRAPPER}.sdl_windowpos_undefined, 500, 600, 0)
		    l_player := create {PLAYER_SHIP}.make (l_window, 100, 200)
		    l_enemy := create {ENEMY_SHIP}.make ("enemyUFO", l_window, 100, 200)
		    l_sidebar := create {USER_INTERFACE}.make ("sidebar", l_window, l_window.width - 100, 0)
			l_event := create {EVENT_HANDLER}.make

			--Boucle d'exécution du jeu
			from
			until
				l_shouldquit
			loop
				{SDL_WRAPPER}.sdl_pollevent_noreturn (l_event.event)

				if l_event.is_quit_event then
					l_shouldquit := true
				end

				l_thistime := {SDL_WRAPPER}.sdl_getticks.to_integer_32

				if l_event.is_mouse_down then
					l_player.start_shooting
				end

				if l_event.is_mouse_up then
					l_player.stop_shooting
				end

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
			    l_player.set_x (l_player.x + (l_directionx * l_speed))
			    l_player.set_y (l_player.y + (l_directiony * l_speed))

				l_window.render_clear

	    		--Frame render
			    l_player.update
			    l_enemy.update
			    l_sidebar.update
			    l_window.render

			    --Delay
			    {SDL_WRAPPER}.sdl_delay(5)
			end

		    {SDL_WRAPPER}.sdl_quit
		end

end
