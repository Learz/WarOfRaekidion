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
			l_must_quit: BOOLEAN
			l_new_game: GAME_SCREEN
			l_event: EVENT_HANDLER
			l_key_binding: KEYS
		do
			l_must_quit := false
		    {SDL_WRAPPER}.sdl_init_noreturn ({SDL_WRAPPER}.sdl_init_video_timer)
			l_event := create {EVENT_HANDLER}.make
		    create l_window.make ("War of Raekidion", {SDL_WRAPPER}.sdl_windowpos_undefined, {SDL_WRAPPER}.sdl_windowpos_undefined, 300, 400, {SDL_WRAPPER}.sdl_window_hidden)
			l_key_binding := create {KEYS_FPS}

			from
			until
				l_must_quit
			loop
				if l_event.is_quit_event then
					l_must_quit := true
				end
				l_new_game := create {GAME_SCREEN}.make (l_window, l_key_binding, true, true, "10.70.2.33")
				l_must_quit := l_new_game.must_quit
			end

		    {SDL_WRAPPER}.sdl_quit
		end

end
