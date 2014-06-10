note
	description : "[
					War of Raekidion - The title screen
					The {TITLE_SCREEN} gives the user the choice to either play
					alone or online, access the options or quit the game.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	TITLE_SCREEN

inherit
	SCREEN
		redefine
			manage_key,
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_debug, a_cheat: BOOLEAN)
		-- Initialize `Current' from `a_window' and `a_debug'
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title: SURFACE
			l_background: BACKGROUND
			l_screen: SCREEN
		do
			collection_on
			debug_on := a_debug
			window := a_window
			create l_event.make (window)
			must_quit := false
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			key_binding := create {KEYS_FPS}
			difficulty := 1
			create buttons.make
			l_title := create {TEXT}.make_centered ("War of Raekidion", 32, window, 0, 0, window.width, 150, [255, 255, 255], true)
			create version.make (window.version, 10, window, 3, 397, [64, 64, 96], false)
			version.set_y (version.y - version.height)
			create l_background.make ("title_background", window, 0, 0, 0)
			buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Singleplayer"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 190, "Multiplayer"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 230, "Highscores"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 270, "Options"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 310, "Quit"))
			selection := buttons.first
			button_index := 1
			stop_music
			play_music ("quiet", -1)

			if attached selection as la_selection then
				la_selection.set_image (la_selection.default_image+"_pressed")
			end

			from
			until
				must_quit
			loop
				l_ticks := {SDL}.sdl_getticks.to_integer_32
				l_event.manage_event

				if l_event.is_quit_event then
					must_quit := true
				end

				window.clear
				l_background.update
				l_title.update
				update
				window.render

				if start_game then
					if multiplayer then
						l_screen := create {LOBBY_SCREEN}.make (window, key_binding, difficulty, debug_on, a_cheat)
					else
						l_screen := create {GAME_SCREEN}.make (window, key_binding, true, debug_on, a_cheat, difficulty, void)
						stop_music
						play_music ("quiet", -1)
					end

					start_game := false
					key_binding := l_screen.key_binding
					must_quit := l_screen.must_quit
					is_return_key_pressed := l_screen.is_return_key_pressed
				end

				if highscores then
					l_screen := create {HIGHSCORE_SCREEN}.make (window, key_binding, difficulty, debug_on, a_cheat)
					must_quit := l_screen.must_quit
					key_binding := l_screen.key_binding
					is_return_key_pressed := l_screen.is_return_key_pressed
					highscores := false
				end

				if options then
					l_screen := create {OPTIONS_SCREEN}.make (window, key_binding, difficulty, false, debug_on, a_cheat)
					must_quit := l_screen.must_quit
					key_binding := l_screen.key_binding

					if attached {OPTIONS_SCREEN} l_screen as la_options then
						difficulty := la_options.difficulty
					end

					is_return_key_pressed := l_screen.is_return_key_pressed
					options := false
				end

				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end
		end

feature -- Status

	start_game: BOOLEAN
		-- True if the game is ready to start

	multiplayer: BOOLEAN
		-- True if the multiplayer lobby screen must display

	highscores: BOOLEAN
		-- True if the highscores screen must display

	options: BOOLEAN
		-- True if the option screen must display

feature {NONE} -- Implementation

	difficulty: INTEGER
		-- Difficulty of the game

	manage_key (a_key: INTEGER; a_state: BOOLEAN)
		-- Manage keyboard keys using `a_key' and `a_state'
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					must_quit := true
				end
			else
				if a_key = key_binding.return_key and is_return_key_pressed then
					is_return_key_pressed := false
				end
			end

			precursor {SCREEN} (a_key, a_state)
		end

	click_button (a_button: INTEGER)
		-- Click actions from `a_button'
		do
			if a_button = 1 then
				multiplayer := false
				start_game := true
			elseif a_button = 2 then
				multiplayer := true
				start_game := true
			elseif a_button = 3 then
				highscores := true
			elseif a_button = 4 then
				options := true
			elseif a_button = 5 then
				must_quit := true
			end
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
