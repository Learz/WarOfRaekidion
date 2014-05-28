note
	description	: "[
					War of Raekidion - {APPLICATION} main class
					War of Raekidion is a bullet hell type online multiplayer
					top-down shooter game inspired from Touhou.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Implementation

	version: STRING = "0.7.4"
			-- Current game's version

	window_width: INTEGER = 300
			-- The window's default width

	window_height: INTEGER = 400
			-- The window's default height

	pixel_ratio: DOUBLE = 1.5
			-- The window's default scale

	debug_mode: BOOLEAN
			-- Are some restricted games functionnalities enabled anyway?

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		local
			l_window: WINDOW
			l_title_screen: TITLE_SCREEN
			l_event: EVENT_HANDLER
			l_splash: SPLASH_SCREEN
			l_resources: detachable RESOURCE_LOAD
		do
			if attached separate_character_option_value ('d') as la_parameter then
				debug_mode := true
			end

			{SDL}.sdl_init_noreturn ({SDL}.sdl_init_video_timer_audio)
			{SDL_TTF}.ttf_init_noreturn
			{SDL_MIXER}.mix_init_noreturn ({SDL_MIXER}.mix_init_ogg)
			{SDL_MIXER}.mix_open_audio_noreturn (22050, {SDL_MIXER}.mix_default_format, 2, 4096)
			create l_window.make ("War of Raekidion", {SDL}.sdl_windowpos_undefined, {SDL}.sdl_windowpos_undefined, window_width, window_height, pixel_ratio, {SDL}.sdl_window_hidden, version)
			{SDL}.sdl_show_window (l_window.window)

			if not debug_mode then
				create l_resources.make
				l_resources.launch
				create l_splash.make ("splash", l_window)

				if attached l_resources as la_resources then
					from
					until
						la_resources.must_quit
					loop
					end

					la_resources.join
				end
			end

			{SDL}.sdl_setrenderdrawcolor (l_window.renderer, 0, 0, 0, 255)
			create l_event.make (l_window)
			create l_title_screen.make (l_window, debug_mode)

			if not debug_mode then
				if attached l_resources as la_resources then
					l_resources.destroy
				end
			end

			l_event.destroy
			l_window.destroy
			{SDL_MIXER}.mix_close_audio
			{SDL_MIXER}.mix_quit
			{SDL_TTF}.ttf_quit
			{SDL}.sdl_quit
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
