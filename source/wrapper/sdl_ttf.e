note
	description: "Summary description for {SDL_TTF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SDL_TTF

feature -- Wrapper

--	frozen ttf_init: INTEGER
--		external
--			"C () : int | <SDL_ttf.h>"
--		alias
--			"TTF_Init"
--		end

--	frozen ttf_init_noreturn
--		external
--			"C () | <SDL_ttf.h>"
--		alias
--			"TTF_Init"
--		end

--	frozen ttf_quit
--		external
--			"C () | <SDL_ttf.h>"
--		alias
--			"TTF_Quit"
--		end

--	frozen ttf_open_font (a_file: POINTER; a_size: INTEGER): POINTER
--		external
--			"C (const char*, int) : TTF_Font* | <SDL_ttf.h>"
--		alias
--			"TTF_OpenFont"
--		end

--    frozen r (a_color: POINTER): INTEGER
--        external
--            "C [struct %"SDL.h%"] (SDL_Color): NATURAL_8"
--        alias
--            "r"
--        end

--    frozen g (a_color: POINTER): INTEGER
--        external
--            "C [struct %"SDL.h%"] (SDL_Color): NATURAL_8"
--        alias
--            "g"
--        end

--    frozen b (a_color: POINTER): INTEGER
--        external
--            "C [struct %"SDL.h%"] (SDL_Color): NATURAL_8"
--        alias
--            "b"
--        end

--    frozen a (a_color: POINTER): INTEGER
--        external
--            "C [struct %"SDL.h%"] (SDL_Color): NATURAL_8"
--        alias
--            "a"
--        end

--    frozen set_r (a_color: POINTER; a_red: INTEGER)
--        external
--            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
--        alias
--            "r"
--        end

--    frozen set_g (a_color: POINTER; a_green: INTEGER)
--        external
--            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
--        alias
--            "g"
--        end

--    frozen set_b (a_color: POINTER; a_blue: INTEGER)
--        external
--            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
--        alias
--            "b"
--        end

--    frozen set_a (a_color: POINTER; a_alpha: INTEGER)
--        external
--            "C [struct %"SDL.h%"] (SDL_Color, Uint8)"
--        alias
--            "a"
--        end

--    frozen sizeof_sdl_color_struct: INTEGER
--		external
--			"C inline use <SDL.h>"
--		alias
--			"sizeof (SDL_Color)"
--		end

--	frozen ttf_show_text (a_font: POINTER; a_text: POINTER; a_color: POINTER): POINTER
--		external
--			"C (TTF_Font*, const Uint16*, SDL_Color) : SDL_Surface* | <SDL_ttf.h>"
--		alias
--			"TTF_RenderUNICODE_Solid"
--		end

end
