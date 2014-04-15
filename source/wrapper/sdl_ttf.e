note
	description: "Summary description for {SDL_TTF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SDL_TTF

feature -- Wrapper

	frozen ttf_init: INTEGER
		external
			"C () : int | <SDL_ttf.h>"
		alias
			"TTF_Init"
		end

	frozen ttf_init_noreturn
		external
			"C () | <SDL_ttf.h>"
		alias
			"TTF_Init"
		end

	frozen ttf_quit
		external
			"C () | <SDL_ttf.h>"
		alias
			"TTF_Quit"
		end

	frozen ttf_open_font (a_file: POINTER; a_size: INTEGER): POINTER
		external
			"C (const char*, int) : TTF_Font* | <SDL_ttf.h>"
		alias
			"TTF_OpenFont"
		end

    frozen red (a_color: POINTER): NATURAL_8
        external
            "C [struct %"SDL.h%"] (SDL_Color): Uint8"
        alias
            "r"
        end

    frozen green (a_color: POINTER): NATURAL_8
        external
            "C [struct %"SDL.h%"] (SDL_Color): Uint8"
        alias
            "g"
        end

    frozen blue (a_color: POINTER): NATURAL_8
        external
            "C [struct %"SDL.h%"] (SDL_Color): Uint8"
        alias
            "b"
        end

    frozen set_red (a_color: POINTER; a_red: NATURAL_8)
        external
            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
        alias
            "r"
        end

    frozen set_green (a_color: POINTER; a_green: NATURAL_8)
        external
            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
        alias
            "g"
        end

    frozen set_blue (a_color: POINTER; a_blue: NATURAL_8)
        external
            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
        alias
            "b"
        end

    frozen sizeof_sdl_color_struct: INTEGER
		external
			"C inline use <SDL.h>"
		alias
			"sizeof (SDL_Color)"
		end

	frozen ttf_show_text (font: POINTER; text: POINTER; color: POINTER): POINTER
		external
			"C inline use <SDL_ttf.h>"
		alias
			"TTF_RenderText_Solid ((TTF_Font*)$font, (const char*)$text, *((SDL_Color*)$color))"
		end

end
