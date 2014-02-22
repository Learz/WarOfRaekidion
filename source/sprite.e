note
	description : "War of Raekidion - {SPRITE} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	SPRITE

inherit
	IMAGE_FACTORY_SHARED

create
	create_sprite

feature --Initialisation

	bmp,texture,targetarea,r_renderer:POINTER
	image:IMAGE_FACTORY

	create_sprite(filename:STRING;imgwindow:WINDOW;x,y:INTEGER)
		--Chargement de l'image en mémoire
		local
--			c_filename:C_STRING
		do
			--Assigner le renderer
			r_renderer:= imgwindow.renderer
			--Conversion de la String en String C
--			create c_filename.make ("Graphics/" + filename + ".bmp")
			--Allocation de la mémoire pour le Struct
			targetarea:=targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			--Chargement de l'image bitmap
			image := factory
			bmp := image.get_image (filename)
			if
				bmp.is_default_pointer
			then
				bmp := image.get_image ("error")
			end
--			bmp:={SDL_WRAPPER}.sdl_loadbmp(c_filename.item)
			--Assignation des valeurs au rectangle
		    {SDL_WRAPPER}.set_sdl_rect_x(targetarea, x)
		    {SDL_WRAPPER}.set_sdl_rect_y(targetarea, y)
		    {SDL_WRAPPER}.set_sdl_rect_w(targetarea, {SDL_WRAPPER}.get_sdl_loadbmp_width(bmp))
		    {SDL_WRAPPER}.set_sdl_rect_h(targetarea, {SDL_WRAPPER}.get_sdl_loadbmp_height(bmp))
		    --Chargement du bitmap sur la texture
			{SDL_WRAPPER}.sdl_setcolorkey_noreturn (bmp, {SDL_WRAPPER}.sdl_true, {SDL_WRAPPER}.sdl_maprgb({SDL_WRAPPER}.get_sdl_surface_format(bmp), 255, 0, 255))
		    texture:={SDL_WRAPPER}.sdl_createtexturefromsurface(r_renderer,bmp)
		    --Appliquer la texture sur le rectangle
		    {SDL_WRAPPER}.sdl_rendercopy(r_renderer,texture,create{POINTER},targetarea)
		end

	update_sprite()

		do
		    {SDL_WRAPPER}.sdl_rendercopy(r_renderer,texture,create{POINTER},targetarea)
		end

	destroy_sprite()
		--Déchargement de l'image en mémoire
		do
			--Effacer la texture
			{SDL_WRAPPER}.sdl_destroytexture(texture)
			--Effacer le rectangle
			targetarea.memory_free
		end

feature --Setters

	set_x(pos:DOUBLE)
	do
		{SDL_WRAPPER}.set_sdl_rect_x(targetarea, pos.floor)
	end

	set_y(pos:DOUBLE)
	do
		{SDL_WRAPPER}.set_sdl_rect_y(targetarea, pos.floor)
	end

feature --Constantes

	get_x:DOUBLE
	do
		Result:={SDL_WRAPPER}.get_sdl_rect_x(targetarea)
	end

	get_y:DOUBLE
	do
		Result:={SDL_WRAPPER}.get_sdl_rect_y(targetarea)
	end

end
