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
			l_window:WINDOW
			l_shouldquit:BOOLEAN
			l_player:PLAYER_SHIP
			l_sidebar:USER_INTERFACE
			l_event:EVENT_HANDLER
			l_thistime, l_lasttime, l_stoptime:INTEGER
			l_deltatime:REAL_64
			l_speed, l_directionx, l_directiony:INTEGER
			l_projectile:PROJECTILE
			l_projectile_list: LINKED_LIST[PROJECTILE]
			l_create_projectile:BOOLEAN
			l_projectile_speed:INTEGER
			l_projectile_delay:INTEGER
		do
			l_projectile_speed:=1
			l_shouldquit := false
			l_stoptime := 0
			l_speed := 2
			-- Initialisation de la fenêtre, des images et de leurs conteneurs
		    create l_window.make ("War of Raekidion", sdl_windowpos_undefined, sdl_windowpos_undefined, 500, 600, 0)
		    l_player := create {PLAYER_SHIP}.make (l_window, 0, 200)
		    create l_projectile_list.make
		    -- := create {PROJECTILE}.create_projectile("sbullet", l_window, l_player.get_x.floor, l_player.get_y.floor)
		    l_sidebar := create {USER_INTERFACE}.make ("sidebar", l_window, l_window.width - 100, 0)

			l_event := create {EVENT_HANDLER}.make

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
					l_create_projectile:=true
				end

				if l_event.is_mouse_up then
					l_create_projectile:=false
				end

				if l_create_projectile then
					l_projectile_delay:= (l_projectile_delay+1)\\20

					if l_projectile_delay=0 then
						l_projectile := create{PROJECTILE}.make ("sbullet", l_window, l_player.x+40, l_player.y)
						l_projectile_list.force(l_projectile)
					end
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
			    l_player.set_x (l_player.x + (l_directionx * l_speed))
			    l_player.set_y (l_player.y + (l_directiony * l_speed))

				l_window.render_clear

				from
					l_projectile_list.start
				until
					l_projectile_list.exhausted
				loop
					l_projectile_list.item.set_y (l_projectile_list.item.y - 5 * l_projectile_list.item.speed)
					if l_projectile_list.item.y < -16 or l_projectile_list.item.y > l_window.height then
						l_projectile_list.item.set_speed(-l_projectile_list.item.speed)
					end

					if l_projectile_list.count > 50 then
						l_projectile_list.remove
					else
						l_projectile_list.item.update
						l_projectile_list.forth
					end
				end

	    		--Frame render
			    l_player.update
			    l_sidebar.update
			    l_window.render

			    --Delay
			    sdl_delay(5)
			end

		    sdl_quit
		end

end
