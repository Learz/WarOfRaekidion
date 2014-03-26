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
			l_ticks, l_lasttick, l_deltatime, l_frames:INTEGER
		do
			l_shouldquit := false
			-- Initialisation de la fenêtre, des images et de leurs conteneurs
		    create l_window.make ("War of Raekidion", {SDL_WRAPPER}.sdl_windowpos_undefined, {SDL_WRAPPER}.sdl_windowpos_undefined, 500, 600, 0)
		    l_player := create {PLAYER_SHIP}.make (l_window, 100, 200)
		    l_enemy := create {ENEMY_SHIP}.make ("enemyUFO", l_window, 100, 200)
		    l_sidebar := create {USER_INTERFACE}.make ("sidebar", l_window, l_window.width - 100, 0)
			l_event := create {EVENT_HANDLER}.make
			l_event.on_key_pressed.extend (agent l_player.manage_key)

			--Boucle d'exécution du jeu
			from
			until
				l_shouldquit
			loop
				{SDL_WRAPPER}.sdl_pollevent_noreturn (l_event.event)
				l_event.check_key_pressed

				if l_event.is_quit_event then
					l_shouldquit := true
				end

				l_ticks := {SDL_WRAPPER}.sdl_getticks.to_integer_32
				l_deltatime := l_ticks - l_lasttick
				l_lasttick := l_ticks
				l_frames := l_frames + 1

				l_player.trajectory.print_info

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
