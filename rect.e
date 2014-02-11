note
	description: "Summary description for {SDL_RECT}."
	author: "moi"
	date: "$Date$"
	revision: "$Revision$"

class
	RECT

inherit
	SDL_WRAPPER

create
	create_rect

feature --Initialisation

	targetarea:POINTER

	create_rect(x,y,w,h:INTEGER)
		--Créer le rectangle
		do
			--Allocation de la mémoire pour le Struct
			targetarea:=targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			--Assignation des valeurs au rectangle
		    set_sdl_rect_x(targetarea, x)
		    set_sdl_rect_y(targetarea, y)
		    set_sdl_rect_w(targetarea, w)
		    set_sdl_rect_h(targetarea, h)
		end


	apply_texture(renderer,texture:POINTER)
	--Chargement de la texture sur le rectangle
		do
			sdl_rendercopy(renderer,texture,create{POINTER},targetarea)
		end

	destroy_rect()
	--Déchargement du rectangle en mémoire
		do
			targetarea.memory_free
		end

end
