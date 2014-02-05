note
	description: "Summary description for {SDL_WINDOW}."
	author: "Moi"
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOW

inherit
	SDL_WRAPPER

create
	create_window

feature --Initialisation

	window,renderer:POINTER
	w,h:INTEGER

	create_window(title:STRING;x,y,width,height:INTEGER;flags:NATURAL_32)
		--Créer la fenêtre
		local
			c_title:C_STRING
		do
			--Conversion de la String en String C
			create c_title.make (title)
			--Initialisation de SDL
		    sdl_init_noreturn(sdl_init_video_timer)
			--Création de la fenêtre et du moteur de rendu
		    window:=sdl_createwindow(c_title.item,x,y,width,height,flags)
		    w:=width
		    h:=height
		    renderer:=sdl_createrenderer(window,-1,sdl_renderer_accelerated)
		end

	destroy_window()
		--Décharger le moteur de rendu et la fenêtre en mémoire
		do
			--Détruire le renderer
		    sdl_destroyrenderer(renderer)
		    --Détruire la fenêtre
		    sdl_destroywindow(window)
		end

end
