note
	description : "War of Raekidion - {APPLICATION} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Implementation

	version: STRING = "0.5.3"
	window_width: INTEGER = 300
	window_height: INTEGER = 400
	pixel_ratio: INTEGER = 2

feature {NONE} -- Initialization

	make
		local
			l_window: WINDOW
			l_title_screen: TITLE_SCREEN
			l_event: EVENT_HANDLER
			l_debug: BOOLEAN
		do
			if attached separate_character_option_value ('d') as l_val then
				l_debug := true
			end

		    {SDL}.sdl_init_noreturn ({SDL}.sdl_init_video_timer_audio)
		    {SDL_TTF}.ttf_init_noreturn
		    {SDL_MIXER}.mix_init_noreturn ({SDL_MIXER}.mix_init_ogg)
		    {SDL_MIXER}.mix_open_audio_noreturn (22050, {SDL_MIXER}.mix_default_format, 2, 4096)
		    create l_window.make ("War of Raekidion", {SDL}.sdl_windowpos_undefined, {SDL}.sdl_windowpos_undefined, window_width, window_height, pixel_ratio, {SDL}.sdl_window_hidden)
			create l_event.make (l_window)
		   	{SDL}.sdl_show_window (l_window.window)
			create l_title_screen.make (l_window, version, l_debug)
			{SDL_MIXER}.mix_quit
			{SDL_MIXER}.mix_close_audio
		    {SDL_TTF}.ttf_quit
		    {SDL}.sdl_quit
		end

end
