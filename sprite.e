note
	description: "Summary description for {SDL_SPRITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPRITE

create
	create_sprite

feature --Initialisation

	bmp,texture,targetarea,r_renderer:POINTER

	create_sprite(filename:STRING;imgwindow:WINDOW;x,y:INTEGER)
		--Chargement de l'image en m�moire
		local
			c_filename:C_STRING
		do
			--Assigner le renderer
			r_renderer:= imgwindow.renderer
			--Conversion de la String en String C
			create c_filename.make (filename)
			--Allocation de la m�moire pour le Struct
			targetarea:=targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			--Chargement de l'image bitmap
		    bmp:={SDL_WRAPPER}.sdl_loadbmp(c_filename.item)
			--Assignation des valeurs au rectangle
		    {SDL_WRAPPER}.set_sdl_rect_x(targetarea, x)
		    {SDL_WRAPPER}.set_sdl_rect_y(targetarea, y)
		    {SDL_WRAPPER}.set_sdl_rect_w(targetarea, {SDL_WRAPPER}.get_sdl_loadbmp_width(bmp))
		    {SDL_WRAPPER}.set_sdl_rect_h(targetarea, {SDL_WRAPPER}.get_sdl_loadbmp_height(bmp))
		    --Mettre le rose(RGB(255,0,255)) en transparence
		    {SDL_WRAPPER}.sdl_setcolorkey_noreturn (bmp, {SDL_WRAPPER}.sdl_true, {SDL_WRAPPER}.sdl_maprgb({SDL_WRAPPER}.get_sdl_surface_format(bmp), 255, 0, 255))
		    --Chargement du bitmap sur la texture
		    texture:={SDL_WRAPPER}.sdl_createtexturefromsurface(r_renderer,bmp)
		    --Appliquer la texture sur le rectangle
		    {SDL_WRAPPER}.sdl_rendercopy(r_renderer,texture,create{POINTER},targetarea)
		end

	update_sprite()

		do
		    {SDL_WRAPPER}.sdl_rendercopy(r_renderer,texture,create{POINTER},targetarea)
		end

	destroy_sprite()
		--D�chargement de l'image en m�moire
		do
			--Effacer le bitmap
			{SDL_WRAPPER}.sdl_freesurface(bmp)
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
