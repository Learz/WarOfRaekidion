note
	description : "Butthurt machine"
	date        : "Petit cheval rose et demi"
	revision    : "14"

class
	APPLICATION

inherit
	ARGUMENTS
	SDL_WRAPPER

create
	make

feature {NONE} -- Initialisation

	make
		--Démarrer l'application
		local
			w_window:WINDOW
			quit:BOOLEAN
			e_entity,e_entity2,e_entity3:ENTITY
			eh_event:EVENT_HANDLER
			thistime,lasttime,stoptime,direction_x,direction_y:INTEGER
			deltatime:REAL_64
			angle,ydif,xdif,speed:DOUBLE

		do
			quit:=false
			stoptime:=0
			speed:=2
			-- Initialisation de la fenêtre, des images et de leurs conteneurs
		    w_window := create {WINDOW}.create_window("Butthurt Machine 2000",sdl_windowpos_undefined,sdl_windowpos_undefined,500,600,0)
		    e_entity := create {ENTITY}.create_entity ("Graphics/ship.bmp",w_window,0,200)
		    e_entity2 := create {ENTITY}.create_entity ("Graphics/sbullet.bmp",w_window,0,0)
		    e_entity3 := create {ENTITY}.create_entity ("Graphics/sidebar.bmp",w_window,w_window.w-100,0)

			eh_event := create {EVENT_HANDLER}.create_event_handler();

			--Boucle d'exécution du jeu
			from
			until
				quit
			loop
				sdl_pollevent_noreturn(eh_event.event) --à moins que.. tue ghost tapis

				if eh_event.is_quitevent then
					quit:= true
				end
				if e_entity.get_x >= w_window.w-164 then
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
			    e_entity.set_x (e_entity.get_x+direction_x*speed)
			    e_entity.set_y (e_entity.get_y+direction_y*speed)

	    		--ENGENDRE LE PRÉSENT
			    w_window.renderclear()
			    e_entity2.update_entity()
			    e_entity.update_entity()
			    e_entity3.update_entity()
			    w_window.renderpresent()

			    --Delai en ms(facultatif)
	    		sdl_delay(10)
			end

		    --Fermeture de la fenêtre, des images et de leurs conteneurs
		    e_entity.destroy_entity()
		    e_entity2.destroy_entity()
		    e_entity3.destroy_entity()
		    w_window.destroy_window()

		    --Libère l'espace alloué pour "event"
		    eh_event.destroy_event_handler()

		    --Fermeture de SDL
		    sdl_quit()

		end

end
