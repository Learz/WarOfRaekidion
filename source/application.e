note
	description : "War of Raekidion - {APPLICATION} class"
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
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
			l_new_game: GAME_LOOP
			l_event: EVENT_HANDLER
			l_key_binding: KEYS
		do
			l_must_quit := false
		    {SDL_WRAPPER}.sdl_init_noreturn ({SDL_WRAPPER}.sdl_init_video_timer)
			l_event := create {EVENT_HANDLER}.make
		    create l_window.make ("War of Raekidion", {SDL_WRAPPER}.sdl_windowpos_undefined, {SDL_WRAPPER}.sdl_windowpos_undefined, 500, 600, {SDL_WRAPPER}.sdl_window_opengl)
			l_key_binding := create {KEYS_ARROWS}

			from
			until
				l_must_quit
			loop
				if l_event.is_quit_event then
					l_must_quit := true
				end
				l_new_game := create {GAME_LOOP}.make (l_window, l_key_binding)
				l_must_quit := l_new_game.must_quit
			end

		    {SDL_WRAPPER}.sdl_quit
		end

end
