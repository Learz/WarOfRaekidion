note
	description : "War of Raekidion - {WINDOW} class"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	WINDOW

create
	create_window

feature --Initialisation

	window,renderer:POINTER
	w,h:INTEGER

	create_window(title:STRING;x,y,width,height:INTEGER;flags:NATURAL_32)
		--Cr�er la fen�tre
		local
			c_title:C_STRING
		do
			--Conversion de la String en String C
			create c_title.make (title)
			--Initialisation de SDL
		    {SDL_WRAPPER}.sdl_init_noreturn({SDL_WRAPPER}.sdl_init_video_timer)
			--Cr�ation de la fen�tre et du moteur de rendu
		    window:={SDL_WRAPPER}.sdl_createwindow(c_title.item,x,y,width,height,flags)
		    w:=width
		    h:=height
		    renderer:={SDL_WRAPPER}.sdl_createrenderer(window,-1,{SDL_WRAPPER}.sdl_renderer_accelerated)
		end

	render_window()
	do
		{SDL_WRAPPER}.sdl_renderpresent(renderer)
	end

	render_clear()
	do
		{SDL_WRAPPER}.sdl_renderclear(renderer)
	end

	destroy_window()
		--D�charger le moteur de rendu et la fen�tre en m�moire
		do
			--D�truire le renderer
		    {SDL_WRAPPER}.sdl_destroyrenderer(renderer)
		    --D�truire la fen�tre
		    {SDL_WRAPPER}.sdl_destroywindow(window)
		end

end
