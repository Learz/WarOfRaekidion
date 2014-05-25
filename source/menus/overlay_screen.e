note
	description : "[
					War of Raekidion - The overlay screen
					The {OVERLAY_SCREEN} is used to give options to a player while
					playing the game such as quitting or accessing the {OPTIONS_SCREEN}.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	OVERLAY_SCREEN

inherit
	HIGHSCORE
		rename
			make as highscore_make
		end
	SCREEN
		redefine
			manage_key,
			manage_click,
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_return_key_pressed: BOOLEAN; a_title, a_description, a_comment: STRING; a_resume_disabled, a_debug: BOOLEAN; a_difficulty, a_score: INTEGER)
		-- Initialize `Current' from `a_window', `a_key_binding', `a_is_return_key_pressed', `a_title', `a_description', `a_comment', `a_resume_disabled', `a_debug' and `a_difficulty'
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title, l_description, l_comment: TEXT
			l_screen: SCREEN
			l_screenshot: SCREENSHOT
		do
			collection_on
			debug_on := a_debug
			highscore_make
			create buttons.make
			window := a_window
			create l_event.make (window)
			key_binding := a_key_binding
			must_quit := false
			score := a_score
			is_return_key_pressed := a_is_return_key_pressed
			l_event.on_typing.extend (agent manage_typing)
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			create l_title.make_centered (a_title, 24, window, 0, 0, window.width, 150, [255, 255, 255], true)
			create l_description.make_centered (a_description, 16, window, 0, 25, window.width, 150, [255, 255, 255], true)
			create l_comment.make_centered (a_comment, 16, window, 0, 50, window.width, 150, [192, 192, 192], true)
			create version.make_empty (window, 0, 0, [0, 0, 0], false)
			resume_disabled := a_resume_disabled

			if not resume_disabled then
				buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Resume"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Options"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 250, "End game"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 300, "Quit"))
			else
				stop_music
				play_music ("spooky", -1)
				create highscore.make_centered ("Highscore", 10, window, 0, 160, window.width, 0, [255, 255, 255], true)
				create textbox.make ("small_textbox", window, 100, 175)
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 175, "Save"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 225, "End game"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 275, "Quit"))
			end

			selection := buttons.first
			button_index := 1

			if attached selection as la_selection then
				la_selection.set_image (la_selection.default_image+"_pressed")
			end

			create l_screenshot.make (window)

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
				l_screenshot.update
				l_title.update
				l_description.update
				l_comment.update

				if attached highscore as la_highscore then
					la_highscore.update
				end

				if attached textbox as la_textbox then
					la_textbox.update
				end

				update
				window.render

				if options then
					l_screen := create {OPTIONS_SCREEN}.make (window, key_binding, a_difficulty, true, debug_on)
					must_quit := l_screen.must_quit
					key_binding := l_screen.key_binding
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

	resume_disabled: BOOLEAN
		-- True if the resume capabilities must be disabled

	options: BOOLEAN
		-- True if the option screen must display

	textbox_focus: BOOLEAN
		-- True if the textbox is clicked

	highscore_set: BOOLEAN
		-- True if the highscore has been saved

feature {NONE} -- Implementation

	highscore: detachable TEXT
		-- Text for the highscore description

	textbox: detachable TEXTBOX
		-- Textbox object for player name

	score: INTEGER
		-- The points scored throughout the game

	manage_typing (a_key: STRING)
		-- Manage keyboard characters if the textbox is focused
		do
			if attached textbox as la_textbox and textbox_focus then
				if a_key.count = 1 and la_textbox.char_string.count < 3 then
					if
						(a_key.at (1) >= 'A' and a_key.at (1) <= 'Z') or
						(a_key.at (1) >= '0' and a_key.at (1) <= '9')
					then
						la_textbox.char_string.append_character (a_key.at (1))
					end
				elseif a_key.is_equal ("Backspace") then
					la_textbox.char_string.remove_tail (1)
				end
			end
		end

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		-- Manage keyboard keys using `a_key' and `a_state'
		do
			if not textbox_focus then
				if a_state then
					if a_key = key_binding.return_key and not is_return_key_pressed then
						is_return_key_pressed := true
						must_close := true
					end
				else
					if a_key = key_binding.return_key and is_return_key_pressed then
						is_return_key_pressed := false
					end
				end

				precursor {SCREEN} (a_key, a_state)
			end
		end

	manage_click (a_button: NATURAL_32; a_x, a_y: INTEGER; a_state: BOOLEAN)
		-- Manage mouse clicks using `a_button', `a_x', `a_y' and `a_state'
		do
			if attached textbox as la_textbox and a_state then
				if (a_x >= la_textbox.x and a_x <= la_textbox.x + la_textbox.width)
				and (a_y >= la_textbox.y and a_y <= la_textbox.y + la_textbox.height) then
					textbox_focus := true
					la_textbox.set_image (la_textbox.default_image + "_pressed")
				else
					textbox_focus := false
					la_textbox.reset_image
				end
			end

			precursor {SCREEN} (a_button, a_x, a_y, a_state)
		end

	click_button (a_button: INTEGER)
		-- Click actions from `a_button'
		do
			if not resume_disabled then
				if a_button = 1 then
					must_close := true
				elseif a_button = 2 then
					options := true
				elseif a_button = 3 then
					must_end := true
				elseif a_button = 4 then
					must_quit := true
				end
			else
				if attached textbox as la_textbox and then attached highscore as la_highscore and then la_textbox.char_string.count = 3 then
					if a_button = 1 then
						if not highscore_set then
							la_textbox.hide
							buttons.at (1).hide
							la_highscore.set_text ("Highscore saved!", 16)
							la_highscore.recenter
							set_highscore (la_textbox.char_string, score)
							highscore_set := True
						end
					elseif a_button = 2 then
						must_end := true
					elseif a_button = 3 then
						must_quit := true
					end
				end
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
