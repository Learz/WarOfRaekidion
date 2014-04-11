note
	description : "War of Raekidion - {SDL_WRAPPER} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	SDL_WRAPPER

feature -- Fonctions -SDL.h

	frozen sdl_createwindow (a_title: POINTER; a_x, a_y, a_width, a_height: INTEGER; a_flags: NATURAL_32): POINTER

		external
			"C (const char*, int, int, int, int, Uint32) : SDL_Window* | <SDL.h>"
		alias
			"SDL_CreateWindow"
		end

	frozen sdl_sethint (a_name: POINTER; a_value: INTEGER)

		external
			"C (const char*, const char*) | <SDL.h>"
		alias
			"SDL_SetHint"
		end

	frozen sdl_hintrenderscalequality: POINTER

		external
			"C inline use <SDL.h>"
		alias
			"SDL_HINT_RENDER_SCALE_QUALITY"
		end

	frozen sdl_rendersetlogicalsize (a_renderer: POINTER; a_width, a_height: INTEGER)

		external
			"C (SDL_Window*, int, int) | <SDL.h>"
		alias
			"SDL_RenderSetLogicalSize"
		end

	frozen sdl_destroywindow (a_window: POINTER)

		external
			"C (SDL_Window*) | <SDL.h>"
		alias
			"SDL_DestroyWindow"
		end

	frozen sdl_createrenderer (a_window: POINTER; a_index: INTEGER; a_flags: NATURAL_32): POINTER

		external
			"C (SDL_Window*, int, Uint32) : SDL_Renderer* | <SDL.h>"
		alias
			"SDL_CreateRenderer"
		end

	frozen sdl_destroyrenderer (a_renderer: POINTER)

		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_DestroyRenderer"
		end

	frozen sdl_getwindowflags (a_window: POINTER): NATURAL_32
		external
			"C (SDL_Window*) : Uint32 | <SDL.h>"
		alias
			"SDL_GetWindowFlags"
		end

	frozen sdl_quit

		external
			"C () | <SDL.h>"
		alias
			"SDL_Quit"
		end

	frozen sdl_renderclear (a_renderer: POINTER)

		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_RenderClear"
		end

	frozen sdl_rendercopy (a_renderer, a_texture, a_srcrect, a_dstrect: POINTER)

		external
			"C (SDL_Renderer*, SDL_Texture*, SDL_Rect*, SDL_Rect*) | <SDL.h>"
		alias
			"SDL_RenderCopy"
		end

	frozen sdl_rendercopyex (a_renderer, a_texture, a_srcrect, a_dstrect: POINTER; a_angle: DOUBLE; a_center: POINTER; a_flip: NATURAL_32)

		external
			"C (SDL_Renderer*, SDL_Texture*, SDL_Rect*, SDL_Rect*, double, SDL_Point*, SDL_RendererFlip) | <SDL.h>"
		alias
			"SDL_RenderCopyEx"
		end

	frozen sdl_flip_none: NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_FLIP_NONE"
		end

	frozen sdl_renderpresent (a_renderer: POINTER)

		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_RenderPresent"
		end

	frozen sdl_init (a_flags: NATURAL_32): NATURAL

		external
			"C (Uint32) : int | <SDL.h>"
		alias
			"SDL_Init"
		end

	frozen sdl_init_noreturn (a_flags: NATURAL_32)

		external
			"C (Uint32) | <SDL.h>"
		alias
			"SDL_Init"
		end

	frozen sdl_loadbmp (a_file: POINTER): POINTER

		external
			"C (const char*) : SDL_Surface* | <SDL.h>"
		alias
			"SDL_LoadBMP"
		end

	frozen sdl_loadimage (a_file: POINTER): POINTER

		external
			"C (const char*) : SDL_Surface | <SDL_image.h>"
		alias
			"IMG_Load"
		end

	frozen sdl_freesurface (a_surface: POINTER)

		external
			"C (SDL_Surface*) | <SDL.h>"
		alias
			"SDL_FreeSurface"
		end

	frozen sdl_setcolorkey (a_surface: POINTER; a_flags: INTEGER; a_key: NATURAL_32): INTEGER
		external
			"C (SDL_Surface*, int, Uint32) : int | <SDL.h>"
		alias
			"SDL_SetColorKey"
		end

	frozen sdl_setcolorkey_noreturn (a_surface: POINTER; a_flags: INTEGER; a_key: NATURAL_32)
		external
			"C (SDL_Surface*, int, Uint32) | <SDL.h>"
		alias
			"SDL_SetColorKey"
		end

	frozen sdl_maprgb (a_format: POINTER; a_r, a_g, a_b: NATURAL_8): NATURAL_32
		external
			"C (const SDL_PixelFormat*, Uint8, Uint8, Uint8) : Uint32 | <SDL.h>"
		alias
			"SDL_MapRGB"
		end

	frozen sdl_createtexturefromsurface (a_renderer, a_surface: POINTER): POINTER

		external
			"C (SDL_Renderer*, SDL_Surface*) : SDL_Texture* | <SDL.h>"
		alias
			"SDL_CreateTextureFromSurface"
		end

	frozen sdl_destroytexture (a_texture: POINTER)

		external
			"C (SDL_Texture*) | <SDL.h>"
		alias
			"SDL_DestroyTexture"
		end

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

	frozen sdl_delay (a_time: INTEGER)

		external
			"C (int) | <SDL.h>"
		alias
			"SDL_Delay"
		end

	frozen sdl_getticks: NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_GetTicks()"
		end

feature -- Structure Setters -SDL.h

		frozen set_sdl_rect_x (a_sdl_rect:POINTER; a_value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"x"
		end

		frozen set_sdl_rect_y (a_sdl_rect:POINTER; a_value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"y"
		end

		frozen set_sdl_rect_w (a_sdl_rect:POINTER; a_value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"w"
		end

		frozen set_sdl_rect_h (a_sdl_rect:POINTER; a_value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"h"
		end

feature -- Structure Getters -SDL.h

		frozen get_sdl_loadbmp_width (a_sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface) : int"
		alias
			"w"
		end

		frozen get_sdl_loadbmp_height (a_sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface) : int"
		alias
			"h"
		end

		frozen get_sdl_surface_format(a_sdl_surface:POINTER):POINTER

		external
			"C [struct <SDL.h>] (SDL_Surface) : SDL_PixelFormat*"
		alias
			"format"
		end

		frozen get_sdl_rect_x(a_sdl_rect:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Rect) : int"
		alias
			"x"
		end

		frozen get_sdl_rect_y(a_sdl_rect:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Rect) : int"
		alias
			"y"
		end

		frozen get_sdl_surface_w(a_sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface) : int"
		alias
			"w"
		end

		frozen get_sdl_surface_h(a_sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface) : int"
		alias
			"h"
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

feature -- Constantes -SDL.h

	frozen sdl_init_video:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_INIT_VIDEO"
		end

	frozen sdl_init_video_timer:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_INIT_VIDEO | SDL_INIT_TIMER"
		end

	frozen sdl_swsurface:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_SWSURFACE"
		end

	frozen sdl_windowpos_undefined:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOWPOS_UNDEFINED"
		end

	frozen sdl_window_hidden:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOW_HIDDEN"
		end

	frozen sdl_show_window (a_window :POINTER)
		external
			"C (SDL_Window*) | <SDL.h>"
		alias
			"SDL_ShowWindow"
		end

	frozen sdl_window_borderless:NATURAL_32
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOW_BORDERLESS"
		end

	frozen sdl_window_fullscreen_desktop:NATURAL_32
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOW_FULLSCREEN_DESKTOP"
		end

	frozen sdl_renderer_accelerated:NATURAL_32
		external
			"C inline use <SDL.h>"
		alias
			"SDL_RENDERER_ACCELERATED"
		end

	frozen sdl_true:INTEGER
		external
			"C inline use <SDL.h>"
		alias
			"SDL_TRUE"
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

feature --Constantes Clavier -SDL.h

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

feature --Sizeof -SDL.h

	frozen sizeof_sdl_rect_struct:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Rect)"
		end

	frozen sizeof_sdl_event_struct:INTEGER

		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Event)"
		end

end
