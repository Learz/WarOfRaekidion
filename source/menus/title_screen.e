note
	description: "Summary description for {TITLE_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TITLE_SCREEN

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_return_key_pressed: BOOLEAN; a_title: STRING)
		local
			l_ticks: INTEGER
			l_event: EVENT_HANDLER
		do
			l_event := create {EVENT_HANDLER}.make
			window := a_window
			key_binding := a_key_binding
			must_quit := false
			is_return_key_pressed := a_is_return_key_pressed
			l_event.on_key_pressed.extend (agent manage_key)

			from
			until
				must_quit or must_close
			loop
				if l_event.is_quit_event then
					must_quit := true
				end

				l_ticks := l_ticks + 1
				l_event.manage_event
			end
		end

feature -- Status

	must_quit, must_close, is_return_key_pressed: BOOLEAN

feature {NONE} -- Implementation

	key_binding: KEYS
	window: WINDOW

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
				if a_key = key_binding.return_key then
					is_return_key_pressed := false
				end
			end
		end

end
