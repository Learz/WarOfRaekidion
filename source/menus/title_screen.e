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
			click_button
		end
	AUDIO_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW)
		local
			l_ticks: INTEGER
			l_event: EVENT_HANDLER
			l_title: SURFACE
			l_background: BACKGROUND
			l_screen: SCREEN
		do
			l_event := create {EVENT_HANDLER}.make
			window := a_window
			must_quit := false
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			key_binding := create {KEYS_FPS}
			create buttons.make
			l_title := create {TEXT}.make_centered ("War of Raekidion", 32, window, 0, 0, window.width, 150, [255, 255, 255], true)
			create l_background.make ("title_background", window, 0, 0, 0)
			buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Singleplayer"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Multiplayer"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 250, "Options"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 300, "Quit"))
			selection := buttons.first
			button_index := buttons.index
			stop_music
			play_music ("quiet", -1)

			if attached selection as la_selection then
				la_selection.set_image ("button_pressed")
			end

			from
			until
				must_quit
			loop
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
						l_screen := create {LOBBY_SCREEN}.make (window, key_binding)
					else
--						l_screen := create {GAME_SCREEN}.make (window, key_binding, true, void)
						l_screen := create {GAME_SCREEN}.make (window, key_binding, true)
						stop_music
						play_music ("quiet", -1)
					end

					start_game := false
					must_quit := l_screen.must_quit
					is_return_key_pressed := l_screen.is_return_key_pressed
				end

				l_ticks := l_ticks + 1
			end
		end

feature -- Status

	start_game, multiplayer: BOOLEAN

feature {NONE} -- Implementation

	button_index: INTEGER

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					must_quit := true
				elseif a_key = key_binding.move_up_key then
					if attached selection as la_selection then
						la_selection.reset_image
						if la_selection = buttons.first then
							button_index := buttons.count + 1
							selection := buttons.last
						else
							button_index := button_index - 1
							selection := buttons.at (button_index)
						end
						la_selection.set_image ("button_pressed")
					end
				elseif a_key = key_binding.move_down_key then
					if attached selection as la_selection then
						la_selection.reset_image
						if la_selection = buttons.last then
							button_index := 1
							selection := buttons.first
						else
							button_index := button_index + 1
							selection := buttons.at (button_index)
						end
						la_selection.set_image ("button_pressed")
					end
				elseif a_key = key_binding.accept_key then
					if attached selection as la_selection then
						click_button (buttons.index_of (la_selection, 1))
					end
				end
			else
				if a_key = key_binding.return_key and is_return_key_pressed then
					is_return_key_pressed := false
				end
			end
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
			elseif a_button = 4 then
				must_quit := true
			end
		end

end
