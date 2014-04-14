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
		    {SDL}.sdl_init_noreturn ({SDL}.sdl_init_video_timer)
		    --{SDL_TTF}.ttf_init_noreturn
		    create l_window.make ("War of Raekidion", {SDL}.sdl_windowpos_undefined, {SDL}.sdl_windowpos_undefined, 300, 400, {SDL}.sdl_window_hidden)
			create l_event.make
		   	{SDL}.sdl_show_window (l_window.window)
			create l_title_screen.make (l_window)
		    --{SDL_TTF}.ttf_quit
		    {SDL}.sdl_quit
		end

end
