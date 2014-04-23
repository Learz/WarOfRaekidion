note
	description: "Summary description for {SDL_EVENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SDL_EVENTS

feature

	frozen sdl_pollevent (a_event: POINTER): INTEGER

		external
			"C (SDL_Event*) : int | <SDL.h>"
		alias
			"SDL_PollEvent"
		end

	frozen sdl_pollevent_noreturn (a_event: POINTER)

		external
			"C (SDL_Event*) | <SDL.h>"
		alias
			"SDL_PollEvent"
		end

	frozen get_sdl_event_type(a_sdl_event:POINTER):NATURAL_32

		external
			"C [struct <SDL.h>] (SDL_Event) : Uint32"
		alias
			"type"
		end

	frozen get_sdl_keypressed(a_sdl_keypressed:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Event) : SDL_Keycode"
		alias
			"key.keysym.sym"
		end

	frozen get_sdl_mouse_state_noreturn(a_x, a_y:POINTER)

		external
			"C (int*, int*) | <SDL.h>"
		alias
			"SDL_GetMouseState"
		end

	frozen get_sdl_mouse_state(a_x, a_y:POINTER):NATURAL_32

		external
			"C (int*, int*) : Uint32 | <SDL.h>"
		alias
			"SDL_GetMouseState"
		end

	frozen get_sdl_key_name (a_keycode: INTEGER): POINTER

		external
			"C (SDL_Keycode) : const char* | <SDL.h>"
		alias
			"SDL_GetKeyName"
		end

	frozen sdl_quitevent:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_QUIT"
		end

	frozen sdl_mousemotion:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEMOTION"
		end

	frozen sdl_mousebuttondown:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEBUTTONDOWN"
		end

	frozen sdl_mousebuttonup:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEBUTTONUP"
		end

	frozen sdl_keydown:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_KEYDOWN"
		end

	frozen sdl_keyup:NATURAL_32
	
		external
			"C inline use <SDL.h>"
		alias
			"SDL_KEYUP"
		end

	frozen sdlk_a:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_a"
		end

	frozen sdlk_c:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_c"
		end

	frozen sdlk_d:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_d"
		end

	frozen sdlk_e:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_e"
		end

	frozen sdlk_s:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_s"
		end

	frozen sdlk_w:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_w"
		end

	frozen sdlk_x:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_x"
		end

	frozen sdlk_z:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_z"
		end

	frozen sdlk_escape:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_ESCAPE"
		end

	frozen sdlk_lshift:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_LSHIFT"
		end

	frozen sdlk_lctrl:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_LCTRL"
		end

	frozen sdlk_up:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_UP"
		end

	frozen sdlk_down:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_DOWN"
		end

	frozen sdlk_left:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_LEFT"
		end

	frozen sdlk_right:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_RIGHT"
		end

	frozen sdlk_return:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_RETURN"
		end

	frozen sdlk_space:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDLK_SPACE"
		end

end
