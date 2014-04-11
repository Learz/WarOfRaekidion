note
	description : "War of Raekidion - {APPLICATION} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
		local
			l_window: WINDOW
			l_title_screen: TITLE_SCREEN
			l_event: EVENT_HANDLER
		do
		    {SDL_WRAPPER}.sdl_init_noreturn ({SDL_WRAPPER}.sdl_init_video_timer)
		    create l_window.make ("War of Raekidion", {SDL_WRAPPER}.sdl_windowpos_undefined, {SDL_WRAPPER}.sdl_windowpos_undefined, 300, 400, {SDL_WRAPPER}.sdl_window_hidden)
			create l_event.make
		   	{SDL_WRAPPER}.sdl_show_window (l_window.window)
			create l_title_screen.make (l_window)
		    {SDL_WRAPPER}.sdl_quit
		end

end
