note
	description: "Summary description for {WAITING_MENU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WAIT_SCREEN

inherit
	SCREEN
		redefine
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_player: BOOLEAN; a_server: STRING)
		local
			l_address: STRING
			l_ticks: INTEGER
			l_event: EVENT_HANDLER
			l_title: TEXT
			l_network: detachable NETWORK
			l_background: BACKGROUND
			l_screen: detachable GAME_SCREEN
		do
			l_event := create {EVENT_HANDLER}.make
			window := a_window
			must_quit := false
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			key_binding := a_key_binding
			l_address := a_server
			create buttons.make
			l_title := create {TEXT}.make_centered ("Waiting for connection...", 16, window, 0, 0, window.width, 350, [255, 255, 255], true)
			create l_background.make ("title_background", window, 0, 0, 0)
			buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Cancel"))

			from
			until
				must_quit or must_close or must_end
			loop
				l_network := create {NETWORK}.make_waiting (a_is_player, a_server)
				l_network.launch
				l_event.manage_event

				if l_event.is_quit_event then
					must_quit := true
				end

				window.clear
				l_background.update
				l_title.update
				update
				window.render

				if l_network.connected_ip.count > 1 then
					l_screen := create {GAME_SCREEN}.make (window, key_binding, a_is_player, l_network)

					if attached l_screen as la_screen then
						must_quit := l_screen.must_quit
						must_end := l_screen.must_end
					end
				end

				l_ticks := l_ticks + 1
			end
		end

feature -- Status

	hosting: BOOLEAN

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

	click_button (a_button: INTEGER)
		do
			if a_button = 1 then
				must_close := true
			end
		end

end
