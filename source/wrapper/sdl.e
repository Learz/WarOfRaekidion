note
	description : "War of Raekidion - {SDL} is a wrapper for the C library SDL2."
	author		: "Fran�ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	SDL

feature -- Fonctions -SDL.h

	frozen sdl_createwindow (a_title: POINTER; a_x, a_y, a_width, a_height: INTEGER; a_flags: NATURAL_32): POINTER
		-- Create a window
		external
			"C (const char*, int, int, int, int, Uint32) : SDL_Window* | <SDL.h>"
		alias
			"SDL_CreateWindow"
		end

	frozen sdl_sethint (a_name: POINTER; a_value: INTEGER)
		-- Set a hint with normal priority.
		external
			"C (const char*, const char*) | <SDL.h>"
		alias
			"SDL_SetHint"
		end

	frozen sdl_hintrenderscalequality: POINTER
		-- Hint that specifies scaling quality.
		external
			"C inline use <SDL.h>"
		alias
			"SDL_HINT_RENDER_SCALE_QUALITY"
		end

	frozen sdl_rendersetlogicalsize (a_renderer: POINTER; a_width, a_height: INTEGER)
		-- Set a device independent resolution for rendering.
		external
			"C (SDL_Renderer*, int, int) | <SDL.h>"
		alias
			"SDL_RenderSetLogicalSize"
		end

	frozen sdl_destroywindow (a_window: POINTER)
		-- Destroy `a_window'
		external
			"C (SDL_Window*) | <SDL.h>"
		alias
			"SDL_DestroyWindow"
		end

	frozen sdl_createrenderer (a_window: POINTER; a_index: INTEGER; a_flags: NATURAL_32): POINTER
		-- Create a renderer
		external
			"C (SDL_Window*, int, Uint32) : SDL_Renderer* | <SDL.h>"
		alias
			"SDL_CreateRenderer"
		end

	frozen sdl_destroyrenderer (a_renderer: POINTER)
		-- Destroy `a_renderer'
		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_DestroyRenderer"
		end

	frozen sdl_getwindowflags (a_window: POINTER): NATURAL_32
		-- Get the flags of `a_window'
		external
			"C (SDL_Window*) : Uint32 | <SDL.h>"
		alias
			"SDL_GetWindowFlags"
		end

	frozen sdl_quit
		-- Clean up all initialized subsystems
		external
			"C () | <SDL.h>"
		alias
			"SDL_Quit"
		end

	frozen sdl_renderclear (a_renderer: POINTER)
		-- Clear `a_renderer' with the drawing color.
		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_RenderClear"
		end

	frozen sdl_rendercopy (a_renderer, a_texture, a_srcrect, a_dstrect: POINTER)
		-- Copy a portion of `a_texture' to `a_renderer'.
		external
			"C (SDL_Renderer*, SDL_Texture*, SDL_Rect*, SDL_Rect*) | <SDL.h>"
		alias
			"SDL_RenderCopy"
		end

	frozen sdl_rendercopyex (a_renderer, a_texture, a_srcrect, a_dstrect: POINTER; a_angle: DOUBLE; a_center: POINTER; a_flip: NATURAL_32)
		-- Copy a portion `a_texture' to `a_renderer',
		-- Optionally rotate by `a_angle' around `a_center' and also flipping it top-bottom and/or left-right
		external
			"C (SDL_Renderer*, SDL_Texture*, SDL_Rect*, SDL_Rect*, double, SDL_Point*, SDL_RendererFlip) | <SDL.h>"
		alias
			"SDL_RenderCopyEx"
		end

	frozen sdl_flip_none: NATURAL_32
		-- Do not flip
		external
			"C inline use <SDL.h>"
		alias
			"SDL_FLIP_NONE"
		end

	frozen sdl_renderpresent (a_renderer: POINTER)
		-- Update the screen with `a_renderer'
		external
			"C (SDL_Renderer*) | <SDL.h>"
		alias
			"SDL_RenderPresent"
		end

	frozen sdl_init (a_flags: NATURAL_32): NATURAL
		-- Initialize the SDL library
		-- Returns 0 on success or a negative error code on failure.
		external
			"C (Uint32) : int | <SDL.h>"
		alias
			"SDL_Init"
		end

	frozen sdl_init_noreturn (a_flags: NATURAL_32)
		-- Initialize the SDL library
		-- Returns nothing.
		external
			"C (Uint32) | <SDL.h>"
		alias
			"SDL_Init"
		end

--	frozen sdl_loadbmp (a_file: POINTER): POINTER
--		-- Load a surface from a BMP `a_file'.
--		external
--			"C (const char*) : SDL_Surface* | <SDL.h>"
--		alias
--			"SDL_LoadBMP"
--		end

	frozen sdl_loadimage (a_file: POINTER): POINTER
		-- Load `a_file' for use as an image in a new surface.
		external
			"C (const char*) : SDL_Surface | <SDL_image.h>"
		alias
			"IMG_Load"
		end

	frozen sdl_freesurface (a_surface: POINTER)
		-- Free `a_surface'
		external
			"C (SDL_Surface*) | <SDL.h>"
		alias
			"SDL_FreeSurface"
		end

--	frozen sdl_setcolorkey (a_surface: POINTER; a_flags: INTEGER; a_key: NATURAL_32): INTEGER
--		
--		external
--			"C (SDL_Surface*, int, Uint32) : int | <SDL.h>"
--		alias
--			"SDL_SetColorKey"
--		end

--	frozen sdl_setcolorkey_noreturn (a_surface: POINTER; a_flags: INTEGER; a_key: NATURAL_32)
--		external
--			"C (SDL_Surface*, int, Uint32) | <SDL.h>"
--		alias
--			"SDL_SetColorKey"
--		end

--	frozen sdl_maprgb (a_format: POINTER; a_r, a_g, a_b: NATURAL_8): NATURAL_32
--		external
--			"C (const SDL_PixelFormat*, Uint8, Uint8, Uint8) : Uint32 | <SDL.h>"
--		alias
--			"SDL_MapRGB"
--		end

	frozen sdl_createtexturefromsurface (a_renderer, a_surface: POINTER): POINTER
		-- Create a texture from `a_surface'.
		external
			"C (SDL_Renderer*, SDL_Surface*) : SDL_Texture* | <SDL.h>"
		alias
			"SDL_CreateTextureFromSurface"
		end

	frozen sdl_destroytexture (a_texture: POINTER)
		-- Destroy `a_texture'
		external
			"C (SDL_Texture*) | <SDL.h>"
		alias
			"SDL_DestroyTexture"
		end

	frozen sdl_delay (a_time: INTEGER)
		-- Wait `a_time' milliseconds before returning.
		external
			"C (int) | <SDL.h>"
		alias
			"SDL_Delay"
		end

	frozen sdl_getticks: NATURAL_32
		-- Number of milliseconds since the SDL library initialization.
		external
			"C inline use <SDL.h>"
		alias
			"SDL_GetTicks"
		end

feature -- Structure Setters -SDL.h

		frozen set_sdl_rect_x (a_sdl_rect:POINTER; a_value:INTEGER)
		-- Move `a_sdl_rect' to `a_value' pixels on the horizontal axis.
		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"x"
		end

		frozen set_sdl_rect_y (a_sdl_rect:POINTER; a_value:INTEGER)
		-- Move `a_sdl_rect' to `a_value' pixels on the vertical axis.
		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"y"
		end

		frozen set_sdl_rect_w (a_sdl_rect:POINTER; a_value:INTEGER)
		-- Change the width of `a_sdl_rect' to `a_value' pixels.
		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"w"
		end

		frozen set_sdl_rect_h (a_sdl_rect:POINTER; a_value:INTEGER)
		-- Change the height of `a_sdl_rect' to `a_value' pixels.
		external
			"C [struct <SDL.h>] (SDL_Rect, int)"
		alias
			"h"
		end

		frozen set_sdl_window_size (a_window: POINTER; a_w, a_h: INTEGER)
		-- Change the size of `a_window'
		external
			"C (SDL_Window*, int, int) | <SDL.h>"
		alias
			"SDL_SetWindowSize"
		end

feature -- Structure Getters -SDL.h

		frozen get_sdl_loadbmp_width (a_sdl_surface:POINTER):INTEGER
		-- Width of `a_sdl_surface'
		external
			"C [struct <SDL.h>] (SDL_Surface) : int"
		alias
			"w"
		end

		frozen get_sdl_loadbmp_height (a_sdl_surface:POINTER):INTEGER
		-- Height of `a_sdl_surface'
		external
			"C [struct <SDL.h>] (SDL_Surface) : int"
		alias
			"h"
		end

		frozen get_sdl_surface_format(a_sdl_surface:POINTER):POINTER
		-- Format of the pixels stored in `a_sdl_surface'
		external
			"C [struct <SDL.h>] (SDL_Surface) : SDL_PixelFormat*"
		alias
			"format"
		end

		frozen get_sdl_rect_x(a_sdl_rect:POINTER):INTEGER
		-- Horizontal position of `a_sdl_rect'
		external
			"C [struct <SDL.h>] (SDL_Rect) : int"
		alias
			"x"
		end

		frozen get_sdl_rect_y(a_sdl_rect:POINTER):INTEGER
		-- Vertical position of `a_sdl_rect'
		external
			"C [struct <SDL.h>] (SDL_Rect) : int"
		alias
			"y"
		end

		frozen get_sdl_rect_w(a_sdl_rect:POINTER):INTEGER
		-- Width of `a_sdl_rect'
		external
			"C [struct <SDL.h>] (SDL_Rect) : int"
		alias
			"w"
		end

		frozen get_sdl_rect_h(a_sdl_rect:POINTER):INTEGER
		-- Height of `a_sdl_rect'
		external
			"C [struct <SDL.h>] (SDL_Rect) : int"
		alias
			"h"
		end

feature -- Constantes -SDL.h

	frozen sdl_init_video:NATURAL_32
		-- Flag to initialize the video subsystem.
		external
			"C inline use <SDL.h>"
		alias
			"SDL_INIT_VIDEO"
		end

	frozen sdl_init_video_timer:NATURAL_32
		-- Flags to initialize the video and timer subsystems.
		external
			"C inline use <SDL.h>"
		alias
			"SDL_INIT_VIDEO | SDL_INIT_TIMER"
		end

	frozen sdl_init_video_timer_audio:NATURAL_32
		-- Flags to initialize the video, timer and audio subsystems.
		external
			"C inline use <SDL.h>"
		alias
			"SDL_INIT_VIDEO | SDL_INIT_TIMER | SDL_INIT_AUDIO"
		end

--	frozen sdl_swsurface:NATURAL_32

--		external
--			"C inline use <SDL.h>"
--		alias
--			"SDL_SWSURFACE"
--		end

	frozen sdl_windowpos_undefined:INTEGER
		-- Default position of a window
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOWPOS_UNDEFINED"
		end

	frozen sdl_window_hidden:NATURAL_32
		-- Flag for a hidden window
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOW_HIDDEN"
		end

	frozen sdl_show_window (a_window :POINTER)
		-- Unhide `a_window'
		external
			"C (SDL_Window*) | <SDL.h>"
		alias
			"SDL_ShowWindow"
		end

	frozen sdl_window_borderless:NATURAL_32
		-- Flag for an undecorated window
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOW_BORDERLESS"
		end

	frozen sdl_window_fullscreen_desktop:NATURAL_32
		-- Flag for a fullscreen window at the current desktop resolution
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WINDOW_FULLSCREEN_DESKTOP"
		end

	frozen sdl_renderer_accelerated:NATURAL_32
		-- Flag to use hardware acceleration
		external
			"C inline use <SDL.h>"
		alias
			"SDL_RENDERER_ACCELERATED"
		end

--	frozen sdl_true:INTEGER
--		-- True statement for SDL
--		external
--			"C inline use <SDL.h>"
--		alias
--			"SDL_TRUE"
--		end

feature --Sizeof -SDL.h

	frozen sizeof_sdl_rect_struct:INTEGER
		-- Size of the SDL_Rect structure in C
		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Rect)"
		end

	frozen sizeof_sdl_event_struct:INTEGER
		-- Size of the SDL_Event structure in C
		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Event)"
		end

end
