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
			manage_key,
			click_button
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_return_key_pressed: BOOLEAN; a_title: STRING; a_resume_disabled: BOOLEAN)
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title: TEXT
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
			l_title := create {TEXT}.make_centered (a_title, 24, window, 0, 0, window.width, 150, [255, 255, 255], true)
			resume_disabled := a_resume_disabled

			if not resume_disabled then
				buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Resume"))
			end

			buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "End game"))
			buttons.extend (create {BUTTON}.make ("button", window, 100, 250, "Quit"))
			selection := buttons.first
			button_index := 1

			if attached selection as la_selection then
				la_selection.set_image ("button_pressed")
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

				l_title.update
				update
				window.render
				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end
		end

feature -- Status

	resume_disabled: BOOLEAN

feature {NONE} -- Implementation

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
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
		do
			if not resume_disabled then
				if a_button = 1 then
					must_close := true
				elseif a_button = 2 then
					must_end := true
				elseif a_button = 3 then
					must_quit := true
				end
			else
				if a_button = 1 then
					must_end := true
				elseif a_button = 2 then
					must_quit := true
				end
			end
		end

end
