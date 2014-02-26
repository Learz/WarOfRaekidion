note
	description : "War of Raekidion - {WINDOW} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	WINDOW

create
	create_window

feature --Initialisation

	window, renderer:POINTER
	height, width:INTEGER

	create_window(a_title:STRING; a_x, a_y, a_width, a_height:INTEGER; a_flags:NATURAL_32)
		--Créer la fenêtre
		local
			l_c_title:C_STRING
		do
			create l_c_title.make (a_title)
		    {SDL_WRAPPER}.sdl_init_noreturn ({SDL_WRAPPER}.sdl_init_video_timer)
		    height := a_height
		    width := a_width
		    window := {SDL_WRAPPER}.sdl_createwindow (l_c_title.item, a_x, a_y, width, height, a_flags)
		    renderer := {SDL_WRAPPER}.sdl_createrenderer (window, -1, {SDL_WRAPPER}.sdl_renderer_accelerated)
		end

	render_window
	do
		{SDL_WRAPPER}.sdl_renderpresent (renderer)
	end

	render_clear
	do
		{SDL_WRAPPER}.sdl_renderclear (renderer)
	end

	destroy_window
		--Décharger le moteur de rendu et la fenêtre en mémoire
		do
		    {SDL_WRAPPER}.sdl_destroyrenderer (renderer)
		    {SDL_WRAPPER}.sdl_destroywindow (window)
		end

end
