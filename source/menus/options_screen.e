note
	description : "[
						War of Raekidion - The options screen
						The {OPTIONS_SCREEN} allows to change settings about the game such as
						the screen size, the volume and the difficulty.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	OPTIONS_SCREEN

inherit
	SCREEN
		redefine
			manage_key,
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_difficulty: INTEGER; a_in_game: BOOLEAN)
		-- Initialize `Current' from `a_window', `a_key_binding', `a_difficulty' and `a_in_game'
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title: TEXT
			l_background: BACKGROUND
		do
			collection_on
			window := a_window
			create l_event.make (window)
			must_quit := false
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			key_binding := a_key_binding
			difficulty := a_difficulty
			in_game := a_in_game
			create buttons.make
			create descriptions.make
			l_title := create {TEXT}.make_centered ("Options", 24, window, 0, 0, window.width, 150, [255, 255, 255], true)
			create version.make (window.version, 10, window, 3, 397, [64, 64, 96], false)
			version.set_y (version.y - version.height)
			create l_background.make ("title_background", window, 0, 0, 0)
			descriptions.extend (create {TEXT}.make_centered ("Key layout", 10, window, 100, 140, 100, 0, [255, 255, 255], true))

			if attached {KEYS_ARROWS} key_binding then
				buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "ARCADE"))
			elseif attached {KEYS_FPS} key_binding then
				buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "FPS"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Music", 10, window, 100, 190, 40, 0, [255, 255, 255], true))

			if audio_factory.music_volume = 128 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 200, "LOUD"))
			elseif audio_factory.music_volume = 64 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 200, "LOW"))
			else
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 200, "OFF"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Sound effects", 10, window, 160, 190, 40, 0, [255, 255, 255], true))

			if audio_factory.sounds_volume = 128 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 200, "LOUD"))
			elseif audio_factory.sounds_volume = 64 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 200, "LOW"))
			else
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 200, "OFF"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Screen size", 10, window, 100, 240, 40, 0, [255, 255, 255], true))

			if window.scale = 2 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 250, "2x"))
			elseif window.scale = 1.5 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 250, "1.5x"))
			else
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 250, "1x"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Difficulty", 10, window, 160, 240, 40, 0, [255, 255, 255], true))

			if not in_game then
				if difficulty = 1 then
					buttons.extend (create {BUTTON}.make ("small_button", window, 160, 250, "EASY"))
				elseif difficulty = 2 then
					buttons.extend (create {BUTTON}.make ("small_button", window, 160, 250, "HARD"))
				else
					buttons.extend (create {BUTTON}.make ("small_button", window, 160, 250, "HELL"))
				end
			else
				buttons.extend (create {BUTTON}.make ("disabled_small_button", window, 160, 250, ""))
			end

			buttons.extend (create {BUTTON}.make ("button", window, 100, 300, "Back"))
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

				from
					descriptions.start
				until
					descriptions.exhausted
				loop
					descriptions.item.update
					descriptions.forth
				end

				window.render
				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end
		end

feature -- Status

	start_game: BOOLEAN
		-- True if the game is ready to start

	is_server: BOOLEAN
		-- True if the player is hosting

	textbox_focus: BOOLEAN
		-- True if the textbox is focused

	in_game: BOOLEAN
		-- True if the option menu is open while in a game

feature -- Access

	difficulty: INTEGER
		-- Difficulty of the game

feature {NONE} -- Implementation

	descriptions: LINKED_LIST [TEXT]
		-- Description of each options

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

	click_button (a_button: INTEGER)
		-- Click actions from `a_button'
		do
			if a_button = 1 then
				if attached {KEYS_ARROWS} key_binding then
					buttons.at (a_button).set_text ("FPS")
					buttons.at (a_button).recenter
					key_binding := create {KEYS_FPS}
				elseif attached {KEYS_FPS} key_binding then
					buttons.at (a_button).set_text ("ARCADE")
					buttons.at (a_button).recenter
					key_binding := create {KEYS_ARROWS}
				end
			elseif a_button = 2 then
				if audio_factory.music_volume = 128 then
					buttons.at (a_button).set_text ("LOW")
					buttons.at (a_button).recenter
					audio_factory.set_music_volume (64)
				elseif audio_factory.music_volume = 64 then
					buttons.at (a_button).set_text ("OFF")
					buttons.at (a_button).recenter
					audio_factory.set_music_volume (0)
				else
					buttons.at (a_button).set_text ("LOUD")
					buttons.at (a_button).recenter
					audio_factory.set_music_volume (128)
				end
			elseif a_button = 3 then
				if audio_factory.sounds_volume = 128 then
					buttons.at (a_button).set_text ("LOW")
					buttons.at (a_button).recenter
					audio_factory.set_sounds_volume (64)
				elseif audio_factory.sounds_volume = 64 then
					buttons.at (a_button).set_text ("OFF")
					buttons.at (a_button).recenter
					audio_factory.set_sounds_volume (0)
				else
					buttons.at (a_button).set_text ("LOUD")
					buttons.at (a_button).recenter
					audio_factory.set_sounds_volume (128)
				end
			elseif a_button = 4 then
				if window.scale = 1 then
					buttons.at (a_button).set_text ("1.5x")
					buttons.at (a_button).recenter
					window.change_size (1.5)
				elseif window.scale = 1.5 then
					buttons.at (a_button).set_text ("2x")
					buttons.at (a_button).recenter
					window.change_size (2)
				else
					buttons.at (a_button).set_text ("1x")
					buttons.at (a_button).recenter
					window.change_size (1)
				end
			elseif a_button = 5 then
				if not in_game then
					if difficulty = 1 then
						buttons.at (a_button).set_text ("HARD")
						buttons.at (a_button).recenter
						difficulty := 2
					elseif difficulty = 2 then
						buttons.at (a_button).set_text ("HELL")
						buttons.at (a_button).recenter
						difficulty := 4
					else
						buttons.at (a_button).set_text ("EASY")
						buttons.at (a_button).recenter
						difficulty := 1
					end
				end
			elseif a_button = 6 then
				must_close := true
			end
		end

end
