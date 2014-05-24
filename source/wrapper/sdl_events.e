note
	description : "War of Raekidion - {SDL_EVENTS} is a wrapper for the events section of the C library SDL2."
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	SDL_EVENTS

feature

	frozen sdl_pollevent (a_event: POINTER): INTEGER
		-- Poll `a_event' for currently pending events.
		external
			"C (SDL_Event*) : int | <SDL.h>"
		alias
			"SDL_PollEvent"
		end

	frozen sdl_pollevent_noreturn (a_event: POINTER)
		-- poll `a_event' for currently pending events, returns nothing.
		external
			"C (SDL_Event*) | <SDL.h>"
		alias
			"SDL_PollEvent"
		end

	frozen get_sdl_event_type(a_sdl_event:POINTER):NATURAL_32
		-- Type of `a_sdl_event'
		external
			"C [struct <SDL.h>] (SDL_Event) : Uint32"
		alias
			"type"
		end

	frozen get_sdl_keypressed(a_sdl_keypressed:POINTER):INTEGER
		-- Keycode of `a_sdl_keypressed'
		external
			"C [struct <SDL.h>] (SDL_Event) : SDL_Keycode"
		alias
			"key.keysym.sym"
		end

	frozen get_sdl_mouse_state(a_x, a_y:POINTER):NATURAL_32
		-- X and Y position of the mouse
		external
			"C (int*, int*) : Uint32 | <SDL.h>"
		alias
			"SDL_GetMouseState"
		end

	frozen get_sdl_mouse_state_noreturn(a_x, a_y:POINTER)
		-- X and Y position of the mouse, returns nothing
		external
			"C (int*, int*) | <SDL.h>"
		alias
			"SDL_GetMouseState"
		end

	frozen get_sdl_key_name (a_keycode: INTEGER): POINTER
		-- Name of `a_keycode'
		external
			"C (SDL_Keycode) : const char* | <SDL.h>"
		alias
			"SDL_GetKeyName"
		end

	frozen sdl_quitevent:NATURAL_32
		-- Quit event
		external
			"C inline use <SDL.h>"
		alias
			"SDL_QUIT"
		end

	frozen sdl_mousemotion:NATURAL_32
		-- Mouse motion event
		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEMOTION"
		end

	frozen sdl_mousebuttondown:NATURAL_32
		-- Mouse button down event
		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEBUTTONDOWN"
		end

	frozen sdl_mousebuttonup:NATURAL_32
		-- Mouse button up event
		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEBUTTONUP"
		end

	frozen sdl_keydown:NATURAL_32
		-- Keyboard key down event
		external
			"C inline use <SDL.h>"
		alias
			"SDL_KEYDOWN"
		end

	frozen sdl_keyup:NATURAL_32
		-- Keyboard key up event
		external
			"C inline use <SDL.h>"
		alias
			"SDL_KEYUP"
		end

	frozen sdlk_a:INTEGER
		-- a key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_a"
		end

	frozen sdlk_c:INTEGER
		-- c key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_c"
		end

	frozen sdlk_d:INTEGER
		-- d key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_d"
		end

	frozen sdlk_e:INTEGER
		-- e key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_e"
		end

	frozen sdlk_s:INTEGER
		-- s key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_s"
		end

	frozen sdlk_w:INTEGER
		-- w key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_w"
		end

	frozen sdlk_x:INTEGER
		-- x key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_x"
		end

	frozen sdlk_z:INTEGER
		-- z key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_z"
		end

	frozen sdlk_escape:INTEGER
		-- escape key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_ESCAPE"
		end

	frozen sdlk_lshift:INTEGER
		-- left shift key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_LSHIFT"
		end

	frozen sdlk_lctrl:INTEGER
		-- left control key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_LCTRL"
		end

	frozen sdlk_up:INTEGER
		-- up key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_UP"
		end

	frozen sdlk_down:INTEGER
		-- down key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_DOWN"
		end

	frozen sdlk_left:INTEGER
		-- left key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_LEFT"
		end

	frozen sdlk_right:INTEGER
		-- right key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_RIGHT"
		end

	frozen sdlk_return:INTEGER
		-- return key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_RETURN"
		end

	frozen sdlk_space:INTEGER
		-- space key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_SPACE"
		end

	frozen sdlk_f12:INTEGER
		-- F12 key
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_F12"
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
