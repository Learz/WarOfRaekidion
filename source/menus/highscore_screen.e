note
	description : "[
					War of Raekidion - The options screen
					The {HIGHSCORE_SCREEN} allows to see the most recent 
					and best scores made by you and other players.
				]"
	author		: "Fran?ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	HIGHSCORE_SCREEN

inherit
	DATABASE_MANAGER_SHARED
		rename
			make as database_make
		end
	SCREEN
		redefine
			manage_key,
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
			l_title, l_description: TEXT
			l_background: BACKGROUND
			l_highscores: LINKED_LIST [TUPLE [name: STRING; difficulty, score: INTEGER]]
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
			difficulty := a_difficulty
			create buttons.make
			create scores.make
			create l_title.make_centered ("Highscores", 24, window, 0, 0, window.width, 150, [255, 255, 255], true, false)

			if difficulty = 1 then
				create l_description.make_centered ("CAKE", 16, window, 0, 25, window.width, 150, [128, 255, 128], false, false)
			elseif difficulty = 2 then
				create l_description.make_centered ("EASY", 16, window, 0, 25, window.width, 150, [255, 255, 128], false, false)
			elseif difficulty = 4 then
				create l_description.make_centered ("HARD", 16, window, 0, 25, window.width, 150, [255, 128, 64], false, false)
			elseif difficulty = 8 then
				create l_description.make_centered ("NUTS", 16, window, 0, 25, window.width, 150, [192, 0, 0], false, false)
			else
				create l_description.make_centered ("HELL", 16, window, 0, 25, window.width, 150, [0, 0, 0], false, false)
			end

			create version.make (window.version, 10, window, 3, 397, [64, 64, 96], false, false)
			version.set_y (version.y - version.height)
			create l_background.make ("title_background", window, 0, 0, 0)
			database_make
			l_highscores := highscores (7, difficulty)

			from
				l_highscores.start
			until
				l_highscores.exhausted
			loop
				scores.extend (create {TEXT}.make (l_highscores.item.name+" | "+l_highscores.item.score.out, 16, window, 110, 100+(25*l_highscores.index), [192, 192, 192], true, false))
				l_highscores.forth
			end

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
				l_description.update
				update

				from
					scores.start
				until
					scores.exhausted
				loop
					scores.item.update
					scores.forth
				end

				window.render
				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end
		end

feature -- Access

	difficulty: INTEGER
		-- Difficulty of the game

feature {NONE} -- Implementation

	scores: LINKED_LIST [TEXT]
		-- Every shown scores

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		-- Manage keyboard keys using `a_key' and `a_state'
		do
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

	click_button (a_button: INTEGER)
		-- Click actions from `a_button'
		do
			if a_button = 1 then
				must_close := true
			end
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 Fran?ois Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
