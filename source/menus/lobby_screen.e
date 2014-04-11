note
	description: "Summary description for {LOBBY_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOBBY_SCREEN

inherit
	SCREEN
		redefine
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS)
		local
			l_ticks: INTEGER
			l_event: EVENT_HANDLER
			l_background: BACKGROUND
			l_screen: GAME_SCREEN
		do
			l_event := create {EVENT_HANDLER}.make
			window := a_window
			must_quit := false
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			key_binding := a_key_binding
			create buttons.make
			create l_background.make ("title_background", window, 0, 0, 0)
			buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Join"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Host"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 250, "Back"))

			from
			until
				must_quit or must_close
			loop
				l_event.manage_event

				if l_event.is_quit_event then
					must_quit := true
				end

				window.clear
				l_background.update
				update
				window.render

				if start_game then
					l_screen := create {GAME_SCREEN}.make (window, key_binding, true, true, "10.70.2.33")
					must_quit := l_screen.must_quit
				end

				l_ticks := l_ticks + 1
			end
		end

feature -- Status

	start_game: BOOLEAN

feature {NONE} -- Implementation

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					must_close := true
				elseif a_key = key_binding.move_up_key then
					-- Button selection
				elseif a_key = key_binding.move_down_key then
					-- Button selection
				elseif a_key = key_binding.accept_key then
					-- Button checkup
				end
			else
				if a_key = key_binding.return_key and is_return_key_pressed then
					is_return_key_pressed := false
				end
			end
		end

	click_button (a_button: BUTTON)
		do
				if a_button.title.is_equal ("Join") then
					-- Ask for an IP address
					start_game := true
				elseif a_button.title.is_equal ("Host") then
					-- Initiate connection wait
					start_game := true
				elseif a_button.title.is_equal ("Back") then
					must_close := true
				end
		end

end
