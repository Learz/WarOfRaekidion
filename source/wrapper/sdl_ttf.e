note
	description : "War of Raekidion - {SDL_TTF} is a wrapper for the C library SDL2_ttf."
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	SDL_TTF

feature -- Wrapper

	frozen ttf_init: INTEGER
		-- Initialize the truetype font API.
		external
			"C () : int | <SDL_ttf.h>"
		alias
			"TTF_Init"
		end

	frozen ttf_init_noreturn
		-- Initialize the truetype font API, returns nothing.
		external
			"C () | <SDL_ttf.h>"
		alias
			"TTF_Init"
		end

	frozen ttf_quit
		-- Shutdown and cleanup the truetype font API.
		external
			"C () | <SDL_ttf.h>"
		alias
			"TTF_Quit"
		end

	frozen ttf_open_font (a_file: POINTER; a_size: INTEGER): POINTER
		-- Load `a_file' for use as a font, at `a_size' size.
		external
			"C (const char*, int) : TTF_Font* | <SDL_ttf.h>"
		alias
			"TTF_OpenFont"
		end

    frozen red (a_color: POINTER): NATURAL_8
    	-- Amount of SDL_Color red
        external
            "C [struct %"SDL.h%"] (SDL_Color): Uint8"
        alias
            "r"
        end

    frozen green (a_color: POINTER): NATURAL_8
    	-- Amount of SDL_Color green
        external
            "C [struct %"SDL.h%"] (SDL_Color): Uint8"
        alias
            "g"
        end

    frozen blue (a_color: POINTER): NATURAL_8
    	-- Amount of SDL_Color blue
        external
            "C [struct %"SDL.h%"] (SDL_Color): Uint8"
        alias
            "b"
        end

    frozen set_red (a_color: POINTER; a_red: NATURAL_8)
    	-- Set the red value of `a_color' to `a_red'
        external
            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
        alias
            "r"
        end

    frozen set_green (a_color: POINTER; a_green: NATURAL_8)
    	-- Set the green value of `a_color' to `a_green'
        external
            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
        alias
            "g"
        end

    frozen set_blue (a_color: POINTER; a_blue: NATURAL_8)
    	-- Set the blue value of `a_color' to `a_blue'
        external
            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
        alias
            "b"
        end

    frozen sizeof_sdl_color_struct: INTEGER
    	-- Size of the SDL_Color structure
		external
			"C inline use <SDL.h>"
		alias
			"sizeof (SDL_Color)"
		end

	frozen ttf_show_text (a_font: POINTER; a_text: POINTER; a_color: POINTER): POINTER
		-- Display `a_text' with the `a_font' font and the `a_color' color.
		external
			"C inline use <SDL_ttf.h>"
		alias
			"TTF_RenderText_Solid ((TTF_Font*)$a_font, (const char*)$a_text, *((SDL_Color*)$a_color))"
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
