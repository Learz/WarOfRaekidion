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

	--Création du rectangle
	create_rect(x,y,w,h:INTEGER)
		do
			--Allocation de la mémoire pour le Struct
			targetarea:=targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			--Assignation des valeurs au rectangle
		    set_sdl_rect_x(targetarea, x)
		    set_sdl_rect_y(targetarea, y)
		    set_sdl_rect_w(targetarea, w)
		    set_sdl_rect_h(targetarea, h)
		end

	--Chargement de la texture sur le rectangle
	apply_texture(renderer,texture:POINTER)
		do
			sdl_rendercopy(renderer,texture,create{POINTER},targetarea)
		end

	--Déchargement du rectangle en mémoire
	destroy_rect()
		do
			targetarea.memory_free
		end

end
