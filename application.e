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
			s_image,s_image2,s_image3:IMAGE
			r_rect,r_rect2,r_rect3:RECT
			thistime,lasttime,stoptime:INTEGER
			event:POINTER
			deltatime:REAL_64

		do
			quit:=false
			stoptime:=0
			event:=event.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_event_struct)
			-- Initialisation de la fenêtre, des images et de leurs conteneurs
		    w_window := create {WINDOW}.create_window("Butthurt Machine 2000",sdl_windowpos_undefined,sdl_windowpos_undefined,500,600,0)
		    s_image := create {IMAGE}.load_image ("Graphics/ship.bmp",w_window)
		    s_image2 := create {IMAGE}.load_image ("Graphics/sbullet.bmp",w_window)
		    s_image3 := create {IMAGE}.load_image ("Graphics/sidebar.bmp",w_window)
			r_rect := create {RECT}.create_rect(0,200,get_sdl_loadbmp_width(s_image.bmp),get_sdl_loadbmp_height(s_image.bmp))
			r_rect2 := create{RECT}.create_rect (0,0, get_sdl_loadbmp_width(s_image2.bmp), get_sdl_loadbmp_height(s_image2.bmp))
			r_rect3 := create{RECT}.create_rect (w_window.w-100,0, get_sdl_loadbmp_width(s_image3.bmp), get_sdl_loadbmp_height(s_image3.bmp))

			from
			until--the ship reaches the right side
				quit
			loop
				sdl_pollevent_noreturn(event) --à moins que.. tue ghost tapis
				if get_sdl_event_type(event) = sdl_quitevent then
					quit:= true
				end
				if get_sdl_rect_x(r_rect.targetarea)>=w_window.w-164 then
					quit:= true
				end
				thistime:=sdl_getticks().to_integer_32
				if get_sdl_event_type(event) = sdl_mousebuttondown then
					--Fucking stop the motherfucking timer
					stoptime:=stoptime+thistime-lasttime
				end
				--Calcul du temps
				deltatime:= thistime-lasttime//1000
				lasttime:=thistime

			    --Assignation des valeurs au(x) rectangle(s)
			    set_sdl_rect_x(r_rect.targetarea, (0.1*(deltatime-stoptime)).floor)
			    set_sdl_rect_y(r_rect2.targetarea, (0.2*(deltatime-stoptime)).floor)
			    set_sdl_rect_x(r_rect2.targetarea, (0.1*(deltatime-stoptime)).floor)

	    		--ENGENDRE LE PRÉSENT
			    sdl_renderclear(w_window.renderer)
			    r_rect2.apply_texture(w_window.renderer,s_image2.texture)
			    r_rect.apply_texture(w_window.renderer,s_image.texture)
			    r_rect3.apply_texture(w_window.renderer,s_image3.texture)
			    sdl_renderpresent(w_window.renderer)

			    --Delai en ms(facultatif)
	    		sdl_delay(10)
			end

		    --Fermeture de la fenêtre, des images et de leurs conteneurs
		    w_window.destroy_window()
		    r_rect.destroy_rect()
		    s_image.destroy_image()
		    r_rect2.destroy_rect()
		    s_image2.destroy_image()
		    r_rect3.destroy_rect()
		    s_image3.destroy_image()

		    --Libère l'espace alloué pour "event"
		    event.memory_free

		    --Fermeture de SDL
		    sdl_quit()

		end

end
