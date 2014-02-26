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

	texture, targetarea, renderer:POINTER

	create_sprite(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		--Chargement de l'image en mémoire
		local
			l_image:POINTER
			l_imagefactory:IMAGE_FACTORY
		do
			renderer := a_window.renderer
			targetarea := targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			l_imagefactory := factory
			l_image := l_imagefactory.get_image (a_name)

			if l_image.is_default_pointer then
				l_image := l_imagefactory.get_image ("error")
			end

		    {SDL_WRAPPER}.set_sdl_rect_x (targetarea, a_x)
		    {SDL_WRAPPER}.set_sdl_rect_y (targetarea, a_y)
		    {SDL_WRAPPER}.set_sdl_rect_w (targetarea, {SDL_WRAPPER}.get_sdl_loadbmp_width (l_image))
		    {SDL_WRAPPER}.set_sdl_rect_h (targetarea, {SDL_WRAPPER}.get_sdl_loadbmp_height (l_image))
			--{SDL_WRAPPER}.sdl_setcolorkey_noreturn (l_image, {SDL_WRAPPER}.sdl_true, {SDL_WRAPPER}.sdl_maprgb ({SDL_WRAPPER}.get_sdl_surface_format(l_image), 255, 0, 255))
		    texture := {SDL_WRAPPER}.sdl_createtexturefromsurface(renderer, l_image)
		    update_sprite
		end

	update_sprite
		--Mise à jour de l'image à l'écran
		do
		    {SDL_WRAPPER}.sdl_rendercopy(renderer, texture, create{POINTER}, targetarea)
		end

	destroy_sprite
		--Déchargement de l'image en mémoire
		do
			{SDL_WRAPPER}.sdl_destroytexture (texture)
			targetarea.memory_free
		end

feature --Setters

	set_x(a_pos:DOUBLE)
		do
			{SDL_WRAPPER}.set_sdl_rect_x (targetarea, a_pos.floor)
		end

	set_y(a_pos:DOUBLE)
		do
			{SDL_WRAPPER}.set_sdl_rect_y (targetarea, a_pos.floor)
		end

feature --Constantes

	get_x:DOUBLE
		do
			Result := {SDL_WRAPPER}.get_sdl_rect_x (targetarea)
		end

	get_y:DOUBLE
		do
			Result := {SDL_WRAPPER}.get_sdl_rect_y (targetarea)
		end

end
