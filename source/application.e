note
	description: "[
		War of Raekidion - {APPLICATION} main class
		War of Raekidion is a bullet hell type online multiplayer 
		top-down shooter game inspired from Touhou.
	]"
	author: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Implementation

	version: STRING = "0.7.0"
			-- Current game's version

	window_width: INTEGER = 300
			-- The window's default width

	window_height: INTEGER = 400
			-- The window's default height

	pixel_ratio: INTEGER = 2
			-- The window's default scale

	debug_mode: BOOLEAN = true
			-- Are some restricted games functionnalities enabled anyway?

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		local
			l_window: WINDOW
			l_title_screen: TITLE_SCREEN
			l_event: EVENT_HANDLER
		do
--			if attached separate_character_option_value ('d') as la_parameter then
--				debug_mode := true
--			end

			{SDL}.sdl_init_noreturn ({SDL}.sdl_init_video_timer_audio)
			{SDL_TTF}.ttf_init_noreturn
			{SDL_MIXER}.mix_init_noreturn ({SDL_MIXER}.mix_init_ogg)
			{SDL_MIXER}.mix_open_audio_noreturn (22050, {SDL_MIXER}.mix_default_format, 2, 4096)
			create l_window.make ("War of Raekidion", {SDL}.sdl_windowpos_undefined, {SDL}.sdl_windowpos_undefined, window_width, window_height, pixel_ratio, {SDL}.sdl_window_hidden, version)
			create l_event.make (l_window)
			{SDL}.sdl_show_window (l_window.window)
			create l_title_screen.make (l_window, debug_mode)
			l_event.destroy
			l_window.destroy
			{SDL_MIXER}.mix_close_audio
			{SDL_MIXER}.mix_quit
			{SDL_TTF}.ttf_quit
			{SDL}.sdl_quit
		end

end
