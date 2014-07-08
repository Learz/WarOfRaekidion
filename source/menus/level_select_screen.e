note
	description : "[
					War of Raekidion - The level selection screen
					The {LEVEL_SELECT_SCREEN} serves as a menu to choose whether the player hosts 
					or connect to someone by putting the IP adress in the textbox.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	LEVEL_SELECT_SCREEN

inherit
	SCREEN
		redefine
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_difficulty: INTEGER; a_debug, a_cheat: BOOLEAN)
		-- Initialize `Current' from `a_window', `a_key_binding' and `a_difficulty'
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title: TEXT
			l_background: BACKGROUND
			l_screen: detachable GAME_SCREEN
		do
			collection_on
			debug_on := a_debug
			window := a_window
			create l_event.make (window)
			must_quit := false
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			key_binding := a_key_binding
			page := 1
			create buttons.make
			l_title := create {TEXT}.make_centered ("Singleplayer", 24, window, 0, 0, window.width, 150, [255, 255, 255], true, false)
			create version.make (window.version, 10, window, 3, 397, [64, 64, 96], false, false)
			version.set_y (version.y - version.height)
			create l_background.make ("title_background", window, 0, 0, 0)
			buttons.extend (create {BUTTON}.make ("small_button", window, 100, 150, "1"))
			buttons.extend (create {BUTTON}.make ("small_button", window, 160, 150, "2"))
			buttons.extend (create {BUTTON}.make ("small_button", window, 100, 190, "3"))
			buttons.extend (create {BUTTON}.make ("small_button", window, 160, 190, "4"))
			buttons.extend (create {BUTTON}.make ("disabled_small_button", window, 100, 230, " "))
			buttons.extend (create {BUTTON}.make ("small_button", window, 160, 230, "Next"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 270, "Endless Mode"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 310, "Back"))
			selection := buttons.first
			button_index := 1

			if attached selection as la_selection then
				la_selection.set_image (la_selection.default_image+"_pressed")
			end

			from
			until
				must_quit or must_close or must_end
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
					if selected_level = 0 then
						l_screen := create {GAME_SCREEN}.make (window, key_binding, true, debug_on, a_cheat, a_difficulty, void)
					else
						l_screen := create {GAME_SCREEN}.make (window, key_binding, true, debug_on, a_cheat, a_difficulty, void)
					end

					stop_music
					play_music ("quiet", -1)
					start_game := false
					key_binding := l_screen.key_binding

					if attached l_screen as la_screen then
						must_quit := l_screen.must_quit
						must_end := l_screen.must_end
					end
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

feature {NONE} -- Implementation

	page: INTEGER
		-- Current levels page

	selected_level: INTEGER
		-- Currently selected level for singleplayer game

	click_button (a_button: INTEGER)
		-- Click actions from `a_button'
		do
			if a_button = 1 then
				selected_level := ((page - 1) * 4) + a_button
				start_game := true
			elseif a_button = 2 then
				selected_level := ((page - 1) * 4) + a_button
				start_game := true
			elseif a_button = 3 then
				selected_level := ((page - 1) * 4) + a_button
				start_game := true
			elseif a_button = 4 then
				selected_level := ((page - 1) * 4) + a_button
				start_game := true
			elseif a_button = 5 then
				set_page (page - 1)
			elseif a_button = 6 then
				set_page (page + 1)
			elseif a_button = 7 then
				selected_level := 0
				start_game := true
			elseif a_button = 8 then
				must_close := true
			end
		end

	set_page (a_number: INTEGER)
		do
			if a_number <= 1 then
				buttons.at (1).set_text ("1")
				buttons.at (1).recenter
				buttons.at (2).set_text ("2")
				buttons.at (2).recenter
				buttons.at (3).set_text ("3")
				buttons.at (3).recenter
				buttons.at (4).set_text ("4")
				buttons.at (4).recenter
				buttons.at (5).set_type ("disabled_small_button", "")
				buttons.at (5).set_image (buttons.at (5).default_image)
				buttons.at (5).recenter
				buttons.at (6).set_type ("small_button", "Next")
				buttons.at (6).set_image (buttons.at (6).default_image)
				buttons.at (6).recenter
				page := 1
			elseif a_number = 2 then
				buttons.at (1).set_text ("5")
				buttons.at (1).recenter
				buttons.at (2).set_text ("6")
				buttons.at (2).recenter
				buttons.at (3).set_text ("7")
				buttons.at (3).recenter
				buttons.at (4).set_type ("small_button", "8")
				buttons.at (4).set_image (buttons.at (4).default_image)
				buttons.at (4).recenter
				buttons.at (5).set_type ("small_button", "Prev")
				buttons.at (5).set_image (buttons.at (5).default_image)
				buttons.at (5).recenter
				buttons.at (6).set_type ("small_button", "Next")
				buttons.at (6).set_image (buttons.at (6).default_image)
				buttons.at (6).recenter
				page := 2
			elseif a_number >= 3 then
				buttons.at (1).set_text ("9")
				buttons.at (1).recenter
				buttons.at (2).set_text ("10")
				buttons.at (2).recenter
				buttons.at (3).set_text ("Final")
				buttons.at (3).recenter
				buttons.at (4).set_type ("disabled_small_button", "")
				buttons.at (4).set_image (buttons.at (4).default_image)
				buttons.at (4).recenter
				buttons.at (5).set_type ("small_button", "Prev")
				buttons.at (5).set_image (buttons.at (5).default_image)
				buttons.at (5).recenter
				buttons.at (6).set_type ("disabled_small_button", "")
				buttons.at (6).set_image (buttons.at (6).default_image)
				buttons.at (6).recenter
				page := 3
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
