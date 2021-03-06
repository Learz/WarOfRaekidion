note
	description : "[
					War of Raekidion - The connection screen
					The {WAIT_SCREEN} will wait for a connection to be made between the client 
					and the server, then start the game when the connection is established.
				]"
	author		: "Fran?ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	WAIT_SCREEN

inherit
	SCREEN
		redefine
			manage_key,
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_server, a_debug, a_cheat: BOOLEAN; a_difficulty: INTEGER; a_server: STRING)
		-- Initialize `Current' from `a_window', `a_key_binding', `a_is_server', `a_difficulty' and `a_server'
		local
			l_address, waiting_text: STRING
			l_frames, l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title, l_error: TEXT
			l_network: NETWORK
			l_background: BACKGROUND
			l_screen: detachable GAME_SCREEN
			l_dots: INTEGER
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
			l_address := a_server
			create buttons.make
			create waiting_text.make_from_string ("Waiting for connection")
			l_title := create {TEXT}.make_centered (waiting_text, 16, window, 0, 0, window.width, 350, [255, 255, 255], true, false)
			l_error := create {TEXT}.make_centered ("Connexion error", 16, window, 0, 0, window.width, 350, [255, 255, 255], true, false)
			l_error.hide
			create version.make (window.version, 10, window, 3, 397, [64, 64, 96], false, false)
			version.set_y (version.y - version.height)
			create l_background.make ("title_background", window, 0, 0, 0)
			buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Cancel"))
			selection := buttons.first
			button_index := 1

			if attached selection as la_selection then
				la_selection.set_image (la_selection.default_image+"_pressed")
			end

			if a_is_server then
				create l_network.make_server
			else
				create l_network.make_client (a_server)
			end

			l_network.launch

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

				if not connection_error and l_frames \\ 60 = 0 then
					if l_dots < 3 then
						l_title.set_text (l_title.text + ".", 16)
						l_dots := l_dots + 1
					else
						l_dots := 0
						l_title.set_text (waiting_text, 16)
					end
				end

				update

				if l_network.connection_error then
					connection_error := true
					l_network.quit
					l_title.hide
					l_error.show
					l_error.update
				else
					l_title.update
				end

				window.render

				if l_network.is_init then
--					l_screen := create {GAME_SCREEN}.make (window, key_binding, a_is_server, debug_on, a_difficulty, l_network)
					l_screen := create {GAME_SCREEN}.make (window, key_binding, true, debug_on, a_cheat, 2, l_network)
					key_binding := l_screen.key_binding
					stop_music

					if attached l_screen as la_screen then
						must_quit := l_screen.must_quit
						must_end := l_screen.must_end

						if not must_quit then
							play_music ("quiet", -1)
						end
					end
				end

				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end

				l_frames := l_frames + 1
			end

			l_network.quit
		end

feature -- Status

	hosting: BOOLEAN
		-- True if the player is hosting the session

	connection_error: BOOLEAN
		-- True if there is any connection error

feature {NONE} -- Implementation

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
