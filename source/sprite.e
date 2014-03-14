note
	description : "War of Raekidion - {SPRITE} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	SPRITE

inherit
	IMAGE_FACTORY_SHARED
	DISPOSABLE

create
	make

feature {NONE} --Initialisation

	texture, targetarea, renderer:POINTER

	make(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		--Chargement de l'image en mémoire
		local
			l_image:POINTER
			l_imagefactory:IMAGE_FACTORY
		do
			renderer := a_window.renderer
			targetarea := targetarea.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_rect_struct)
			l_imagefactory := factory
			l_image := l_imagefactory.image (a_name)

			if l_image.is_default_pointer then
				l_image := l_imagefactory.image ("error")
			end

		    set_x (a_x)
		    set_y (a_y)
		    width := {SDL_WRAPPER}.get_sdl_loadbmp_width (l_image)
		    height := {SDL_WRAPPER}.get_sdl_loadbmp_height (l_image)
		    {SDL_WRAPPER}.set_sdl_rect_w (targetarea, width)
		    {SDL_WRAPPER}.set_sdl_rect_h (targetarea, height)
			texture := {SDL_WRAPPER}.sdl_createtexturefromsurface(renderer, l_image)
		end

	dispose
		--Déchargement de l'image en mémoire
		do
			{SDL_WRAPPER}.sdl_destroytexture (texture)
			targetarea.memory_free
		end

feature --Setters

	update
		--Mise à jour de l'image à l'écran
		do
		    {SDL_WRAPPER}.sdl_rendercopy(renderer, texture, create {POINTER}, targetarea)
		end

	set_x(a_pos:INTEGER)
		do
			{SDL_WRAPPER}.set_sdl_rect_x (targetarea, a_pos)
		end

	set_y(a_pos:INTEGER)
		do
			{SDL_WRAPPER}.set_sdl_rect_y (targetarea, a_pos)
		end

feature --Getters

	width, height: INTEGER

	x:INTEGER
		do
			Result := {SDL_WRAPPER}.get_sdl_rect_x (targetarea)
		end

	y:INTEGER
		do
			Result := {SDL_WRAPPER}.get_sdl_rect_y (targetarea)
		end

end
