note
	description: "Summary description for {SDL_SPRITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IMAGE

inherit
	SDL_WRAPPER

create
	load_image

feature --Initialisation

	bmp,texture:POINTER

	load_image(filename:STRING;imgwindow:WINDOW)
		--Chargement de l'image en mémoire
		local
			c_filename:C_STRING
		do
			--Conversion de la Strin en String C
			create c_filename.make (filename)

			--Chargement de l'image bitmap
		    bmp:=sdl_loadbmp(c_filename.item)
		    --Mettre le rose(RGB(255,0,255)) en transparence
		    sdl_setcolorkey_noreturn (bmp, sdl_true, sdl_maprgb(get_sdl_surface_format(bmp), 255, 0, 255))
		    --Chargement du bitmap sur la texture
		    texture:=sdl_createtexturefromsurface(imgwindow.renderer,bmp)
		end

	destroy_image()
		--Déchargement de l'image en mémoire
		do
			--Effacer le bitmap
			sdl_freesurface(bmp)
			--Effacer la texture
			sdl_destroytexture(texture)
		end

end
