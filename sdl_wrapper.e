note
	description: "Butthurt origins"
	author: "Headon, apply directly to the forehead.Headon, apply directly to the forehead.Headon, apply directly to the forehead.Headon, apply directly to the forehead"
	date: "$Date$"
	revision: "$Revision$"

class
	SDL_WRAPPER

feature -- Fonctions -SDL.h

	frozen sdl_createwindow(title:POINTER;x,y,w,h:INTEGER;flags:NATURAL_32):POINTER

		external
			"C (const char*,int,int,int,int,Uint32) : SDL_Window* | <SDL.h>"
		alias
			"SDL_CreateWindow"
		end

	frozen sdl_destroywindow(window:POINTER)

		external
			"C (SDL_Window*) | <SDL.h>"
		alias
			"SDL_DestroyWindow"
		end

	frozen sdl_quit()

		external
			"C () | <SDL.h>"
		alias
			"SDL_Quit"
		end

	frozen sdl_createrenderer(window:POINTER;index:INTEGER;flags:NATURAL_32):POINTER

		external
			"C (SDL_Window*,int,Uint32) : SDL_Renderer* | <SDL.h>"
		alias
			"SDL_CreateRenderer"
		end

	frozen sdl_destroyrenderer (renderer:POINTER)

		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_DestroyRenderer"
		end

	frozen sdl_renderclear(renderer:POINTER)

		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_RenderClear"
		end

	frozen sdl_rendercopy(renderer,texture,srcrect,dstrect:POINTER;)

		external
			"C (SDL_Renderer*,SDL_Texture*,SDL_Rect*,SDL_Rect*) | <SDL.h>"
		alias
			"SDL_RenderCopy"
		end

	frozen sdl_renderpresent(renderer:POINTER)

		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_RenderPresent"
		end

	frozen sdl_init(flags:NATURAL_32):NATURAL

		external
			"C (Uint32) : int | <SDL.h>"
		alias
			"SDL_Init"
		end

	frozen sdl_init_noreturn(flags:NATURAL_32)

		external
			"C (Uint32) | <SDL.h>"
		alias
			"SDL_Init"
		end

	frozen sdl_loadbmp(file:POINTER):POINTER

		external
			"C (const char*) : SDL_Surface* | <SDL.h>"
		alias
			"SDL_LoadBMP"
		end

	frozen sdl_freesurface(surface:POINTER)

		external
			"C (SDL_Surface*) | <SDL.h>"
		alias
			"SDL_FreeSurface"
		end

	frozen sdl_setcolorkey(surface:POINTER;flags:INTEGER;key:NATURAL_32):INTEGER
		external
			"C (SDL_Surface*,int,Uint32) : int | <SDL.h>"
		alias
			"SDL_SetColorKey"
		end

	frozen sdl_setcolorkey_noreturn(surface:POINTER;flags:INTEGER;key:NATURAL_32)
		external
			"C (SDL_Surface*,int,Uint32) | <SDL.h>"
		alias
			"SDL_SetColorKey"
		end

	frozen sdl_maprgb(format:POINTER;r,g,b:NATURAL_8):NATURAL_32
		external
			"C (const SDL_PixelFormat*,Uint8,Uint8,Uint8) : Uint32 | <SDL.h>"
		alias
			"SDL_MapRGB"
		end

	frozen sdl_createtexturefromsurface(renderer,surface:POINTER):POINTER

		external
			"C (SDL_Renderer*,SDL_Surface*) : SDL_Texture* | <SDL.h>"
		alias
			"SDL_CreateTextureFromSurface"
		end

	frozen sdl_destroytexture(texture:POINTER)

		external
			"C (SDL_Texture*) | <SDL.h>"
		alias
			"SDL_DestroyTexture"
		end

--	Obsolete Function --
--	frozen sdl_blitsurface(src,srcrect,dst,dstrect:POINTER):INTEGER

--		external
--			"C (SDL_Surface*,SDL_Rect*,SDL_Surface*,SDL_Rect*) : int | <SDL.h>"
--		alias
--			"SDL_BlitSurface"
--		end

--	frozen sdl_blitsurface_noreturn(src,srcrect,dst,dstrect:POINTER)

--		external
--			"C (SDL_Surface*,SDL_Rect*,SDL_Surface*,SDL_Rect*) | <SDL.h>"
--		alias
--			"SDL_BlitSurface"
--		end

	frozen sdl_pollevent(event:POINTER):INTEGER

		external
			"C (SDL_Event*):int | <SDL.h>"
		alias
			"SDL_PollEvent"
		end

	frozen sdl_pollevent_noreturn(event:POINTER)

		external
			"C (SDL_Event*) | <SDL.h>"
		alias
			"SDL_PollEvent"
		end

	frozen sdl_delay(time:INTEGER)

		external
			"C (int) | <SDL.h>"
		alias
			"SDL_Delay"
		end

	frozen sdl_getticks():NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_GetTicks()"
		end

feature -- Structure Setters -SDL.h

		frozen set_sdl_rect_x (sdl_rect:POINTER;value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"x"
		end

		frozen set_sdl_rect_y (sdl_rect:POINTER;value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"y"
		end

		frozen set_sdl_rect_w (sdl_rect:POINTER;value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"w"
		end

		frozen set_sdl_rect_h (sdl_rect:POINTER;value:INTEGER)

		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"h"
		end

feature -- Structure Getters -SDL.h

		frozen get_sdl_loadbmp_width (sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface):int"
		alias
			"w"
		end

		frozen get_sdl_loadbmp_height (sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface):int"
		alias
			"h"
		end

		frozen get_sdl_surface_format(sdl_surface:POINTER):POINTER

		external
			"C [struct <SDL.h>] (SDL_Surface):SDL_PixelFormat*"
		alias
			"format"
		end

		frozen get_sdl_rect_x(sdl_rect:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Rect):int"
		alias
			"x"
		end

		frozen get_sdl_rect_y(sdl_rect:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Rect):int"
		alias
			"y"
		end

		frozen get_sdl_surface_w(sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface):int"
		alias
			"w"
		end

		frozen get_sdl_surface_h(sdl_surface:POINTER):INTEGER

		external
			"C [struct <SDL.h>] (SDL_Surface):int"
		alias
			"h"
		end

		frozen get_sdl_event_type(sdl_event:POINTER):NATURAL_32

		external
			"C [struct <SDL.h>] (SDL_Event):Uint32"
		alias
			"type"
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
			"SDL_INIT_VIDEO|SDL_INIT_TIMER"
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

	frozen sdl_window_opengl:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOW_OPENGL"
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

	frozen sdl_mousebuttondown:NATURAL_32

		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEBUTTONDOWN"
		end

feature --Sizeof -SDL.H

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
