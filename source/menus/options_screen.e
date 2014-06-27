note
	description : "[
					War of Raekidion - The options screen
					The {OPTIONS_SCREEN} allows to change settings about the game such as
					the screen size, the volume and the difficulty.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

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

	make (a_window: WINDOW; a_key_binding: KEYS; a_difficulty: INTEGER; a_in_game, a_debug, a_cheat: BOOLEAN)
		-- Initialize `Current' from `a_window', `a_key_binding', `a_difficulty' and `a_in_game'
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title: TEXT
			l_background: BACKGROUND
		do
			collection_on
			create config.make
			config.load ("config.xml")
			fallback := not config.enabled
			debug_on := a_debug
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

			if fallback then
				config_value := key_binding.id
			else
				config_value := config.keybind
			end

			if config_value.floor = 2 then
				buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "ARCADE"))
			elseif config_value.floor = 1 then
				buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "FPS"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Music", 10, window, 100, 190, 40, 0, [255, 255, 255], true))

			if fallback then
				config_value := audio_factory.music_volume
			else
				config_value := config.music_volume
			end

			if config_value.floor = 100 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 200, "LOUD"))
			elseif config_value.floor = 66 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 200, "HIGH"))
			elseif config_value.floor = 33 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 200, "LOW"))
			else
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 200, "OFF"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Sound effects", 10, window, 160, 190, 40, 0, [255, 255, 255], true))

			if fallback then
				config_value := audio_factory.sounds_volume
			else
				config_value := config.sounds_volume
			end

			if config_value.floor = 100 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 200, "LOUD"))
			elseif config_value.floor = 66 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 200, "HIGH"))
			elseif config_value.floor = 33 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 200, "LOW"))
			else
				buttons.extend (create {BUTTON}.make ("small_button", window, 160, 200, "OFF"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Screen size", 10, window, 100, 240, 40, 0, [255, 255, 255], true))

			if fallback then
				config_value := window.scale
			else
				config_value := config.window_scale
			end

			if config_value = 2 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 250, "2x"))
			elseif config_value = 1.5 then
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 250, "1.5x"))
			else
				buttons.extend (create {BUTTON}.make ("small_button", window, 100, 250, "1x"))
			end

			descriptions.extend (create {TEXT}.make_centered ("Difficulty", 10, window, 160, 240, 40, 0, [255, 255, 255], true))

			if fallback then
				config_value := difficulty
			else
				config_value := config.difficulty
			end

			if not in_game then
				if config_value = 1 then
					buttons.extend (create {BUTTON}.make ("small_button", window, 160, 250, "CAKE"))
				elseif config_value = 2 then
					buttons.extend (create {BUTTON}.make ("small_button", window, 160, 250, "EASY"))
				elseif config_value = 4 then
					buttons.extend (create {BUTTON}.make ("small_button", window, 160, 250, "HARD"))
				elseif config_value = 8 then
					buttons.extend (create {BUTTON}.make ("small_button", window, 160, 250, "NUTS"))
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

	in_game: BOOLEAN
		-- True if the option menu is open while in a game

	fallback: BOOLEAN
		-- True if the config file should not be used

feature -- Access

	difficulty: INTEGER
		-- Difficulty of the game

feature {NONE} -- Implementation

	config: CONFIGURATION
		-- The configuration file

	descriptions: LINKED_LIST [TEXT]
		-- Description of each options

	config_value: DOUBLE
		-- Last value loaded from the config file or the game

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
				if fallback then
					config_value := key_binding.id
				else
					config_value := config.keybind
				end

				if config_value.floor = 2 then
					buttons.at (a_button).set_text ("FPS")
					buttons.at (a_button).recenter
					key_binding := create {KEYS_FPS}
					config.set_keybind (1)
				elseif config_value.floor = 1 then
					buttons.at (a_button).set_text ("ARCADE")
					buttons.at (a_button).recenter
					key_binding := create {KEYS_ARROWS}
					config.set_keybind (2)
				end
			elseif a_button = 2 then
				if fallback then
					config_value := audio_factory.music_volume
				else
					config_value := config.music_volume
				end

				if config_value.floor = 100 then
					buttons.at (a_button).set_text ("HIGH")
					buttons.at (a_button).recenter
					audio_factory.set_music_volume (66)
					config.set_music_volume (66)
				elseif config_value.floor = 66 then
					buttons.at (a_button).set_text ("LOW")
					buttons.at (a_button).recenter
					audio_factory.set_music_volume (33)
					config.set_music_volume (33)
				elseif config_value.floor = 33 then
					buttons.at (a_button).set_text ("OFF")
					buttons.at (a_button).recenter
					audio_factory.set_music_volume (0)
					config.set_music_volume (0)
				else
					buttons.at (a_button).set_text ("LOUD")
					buttons.at (a_button).recenter
					audio_factory.set_music_volume (100)
					config.set_music_volume (100)
				end
			elseif a_button = 3 then
				if fallback then
					config_value := audio_factory.sounds_volume
				else
					config_value := config.sounds_volume
				end

				if config_value.floor = 100 then
					buttons.at (a_button).set_text ("HIGH")
					buttons.at (a_button).recenter
					audio_factory.set_sounds_volume (66)
					config.set_sounds_volume (66)
				elseif config_value.floor = 66 then
					buttons.at (a_button).set_text ("LOW")
					buttons.at (a_button).recenter
					audio_factory.set_sounds_volume (33)
					config.set_sounds_volume (33)
				elseif config_value.floor = 33 then
					buttons.at (a_button).set_text ("OFF")
					buttons.at (a_button).recenter
					audio_factory.set_sounds_volume (0)
					config.set_sounds_volume (0)
				else
					buttons.at (a_button).set_text ("LOUD")
					buttons.at (a_button).recenter
					audio_factory.set_sounds_volume (100)
					config.set_sounds_volume (100)
				end
			elseif a_button = 4 then
				if fallback then
					config_value := window.scale
				else
					config_value := config.window_scale
				end

				if config_value = 1 then
					buttons.at (a_button).set_text ("1.5x")
					buttons.at (a_button).recenter
					window.change_size (1.5)
					config.set_window_scale (1.5)
				elseif config_value = 1.5 then
					buttons.at (a_button).set_text ("2x")
					buttons.at (a_button).recenter
					window.change_size (2)
					config.set_window_scale (2)
				else
					buttons.at (a_button).set_text ("1x")
					buttons.at (a_button).recenter
					window.change_size (1)
					config.set_window_scale (1)
				end
			elseif a_button = 5 then
				if not in_game then
					if fallback then
						config_value := difficulty
					else
						config_value := config.difficulty
					end

					if config_value.floor = 8 then
						buttons.at (a_button).set_text ("HELL")
						buttons.at (a_button).recenter
						difficulty := 16
						config.set_difficulty (16)
					elseif config_value.floor = 4 then
						buttons.at (a_button).set_text ("NUTS")
						buttons.at (a_button).recenter
						difficulty := 8
						config.set_difficulty (8)
					elseif config_value.floor = 2 then
						buttons.at (a_button).set_text ("HARD")
						buttons.at (a_button).recenter
						difficulty := 4
						config.set_difficulty (4)
					elseif config_value.floor = 1 then
						buttons.at (a_button).set_text ("EASY")
						buttons.at (a_button).recenter
						difficulty := 2
						config.set_difficulty (2)
					else
						buttons.at (a_button).set_text ("CAKE")
						buttons.at (a_button).recenter
						difficulty := 1
						config.set_difficulty (1)
					end
				end
			elseif a_button = 6 then
				if not fallback then
					config.save ("config.xml")
				end

				must_close := true
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
