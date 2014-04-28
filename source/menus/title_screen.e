note
	description: "Summary description for {TITLE_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TITLE_SCREEN

inherit
	SCREEN
		redefine
			manage_key,
			click_button
		end
	AUDIO_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_version: STRING)
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title: SURFACE
			l_version: TEXT
			l_background: BACKGROUND
			l_screen: SCREEN
		do
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
			l_version := create {TEXT}.make (a_version, 10, window, 3, 387, [64, 64, 96], false)
			create l_background.make ("title_background", window, 0, 0, 0)
			buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Singleplayer"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Multiplayer"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 250, "Options"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 300, "Quit"))
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
				l_version.update
				update
				window.render

				if start_game then
					if multiplayer then
						l_screen := create {LOBBY_SCREEN}.make (window, key_binding, difficulty)
					else
						l_screen := create {GAME_SCREEN}.make (window, key_binding, true, difficulty, void)
						stop_music
						play_music ("quiet", -1)
					end

					start_game := false
					must_quit := l_screen.must_quit
					is_return_key_pressed := l_screen.is_return_key_pressed
				end

				if options then
					l_screen := create {OPTIONS_SCREEN}.make (window, key_binding, difficulty)
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

	start_game, multiplayer, options: BOOLEAN

feature {NONE} -- Implementation

	difficulty: INTEGER

	manage_key (a_key: INTEGER; a_state: BOOLEAN)
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
		do
			if a_button = 1 then
				multiplayer := false
				start_game := true
			elseif a_button = 2 then
				multiplayer := true
				start_game := true
			elseif a_button = 3 then
				options := true
			elseif a_button = 4 then
				must_quit := true
			end
		end

end
