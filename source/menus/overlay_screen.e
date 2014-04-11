note
	description: "Summary description for {OVERLAY_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OVERLAY_SCREEN

inherit
	SCREEN
		redefine
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_return_key_pressed: BOOLEAN; a_title: STRING)
		local
			l_ticks: INTEGER
			l_event: EVENT_HANDLER
		do
			create l_event.make
			create buttons.make
			window := a_window
			key_binding := a_key_binding
			must_quit := false
			is_return_key_pressed := a_is_return_key_pressed
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Resume"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Quit"))

			from
			until
				must_quit or must_close
			loop
				l_event.manage_event

				if l_event.is_quit_event then
					must_quit := true
				end

				update
				window.render

				l_ticks := l_ticks + 1
			end
		end

feature {NONE} -- Implementation

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					must_close := true
				elseif a_key = key_binding.accept_key then
					must_quit := true
				end
			else
				if a_key = key_binding.return_key and is_return_key_pressed then
					is_return_key_pressed := false
				end
			end
		end

	click_button (a_button: BUTTON)
		do
				if a_button.title.is_equal ("Resume") then
					must_close := true
				elseif a_button.title.is_equal ("Quit") then
					must_quit := true
				end
		end

end
