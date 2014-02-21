note
	description : "War of Raekidion - {APPLICATION} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	APPLICATION

inherit
	ARGUMENTS
	SDL_WRAPPER
	IMAGE_FACTORY_SHARED

create
	make

feature {NONE} -- Initialisation

	make
		--Démarrer l'application
		local
			image:IMAGE_FACTORY
			w_window:WINDOW
			quit:BOOLEAN
			player:PLAYER_SHIP
			sidebar:USER_INTERFACE
			eh_event:EVENT_HANDLER
			thistime,lasttime,stoptime:INTEGER
			deltatime:REAL_64
			speed,direction_x,direction_y:DOUBLE

		do
			quit:=false
			stoptime:=0
			speed:=2
			-- Initialisation de la fenêtre, des images et de leurs conteneurs
		    w_window := create {WINDOW}.create_window("War of Raekidion",sdl_windowpos_undefined,sdl_windowpos_undefined,500,600,0)
		    player := create {PLAYER_SHIP}.create_ship (w_window,0,200)
		    sidebar := create {USER_INTERFACE}.create_interface ("sidebar",w_window,w_window.w-100,0)

			eh_event := create {EVENT_HANDLER}.create_event_handler();

			--Boucle d'exécution du jeu
			from
			until
				quit
			loop
				sdl_pollevent_noreturn(eh_event.event)

				if eh_event.is_quitevent then
					quit:= true
				end

				thistime:=sdl_getticks().to_integer_32

				if eh_event.is_mousedown then
					--Fucking stop the motherfucking timer
					stoptime:=stoptime+thistime-lasttime
				end

				eh_event.get_keypressed()

				if eh_event.is_keydown then
					if eh_event.is_key_w then
						direction_y:=-1
					end
					if eh_event.is_key_a then
						direction_x:=-1
					end
					if eh_event.is_key_s then
						direction_y:=1
					end
					if eh_event.is_key_d then
						direction_x:=1
					end
					if eh_event.is_key_lshift then
						speed:=1
					end
				end
				if eh_event.is_keyup then
					if eh_event.is_key_w and direction_y<0 then
						direction_y:=0
					end
					if eh_event.is_key_a and direction_x<0 then
						direction_x:=0
					end
					if eh_event.is_key_s and direction_y>0 then
						direction_y:=0
					end
					if eh_event.is_key_d and direction_x>0 then
						direction_x:=0
					end
					if eh_event.is_key_lshift then
						speed:=2
					end
				end

				--Calcul du temps
				deltatime:= thistime-lasttime
				lasttime:=thistime

			    --Try to move the entities
			    player.set_x (player.get_x+direction_x*speed)
			    player.set_y (player.get_y+direction_y*speed)

	    		--ENGENDRE LE PRÉSENT
			    w_window.render_clear()
			    player.update_entity()
			    sidebar.update_entity()
			    w_window.render_window()

			    --Delai en ms(facultatif)
	    		sdl_delay(10)
			end

		    --Fermeture de la fenêtre et des entités
		    player.destroy_entity()
		    sidebar.destroy_entity()
		    w_window.destroy_window()

		    --Libère l'espace alloué pour "event"
		    eh_event.destroy_event_handler()

		    --Libère tous les sprites de la RAM
			image := factory
		    image.destroy_images

		    --Fermeture de SDL
		    sdl_quit()

		end

end
