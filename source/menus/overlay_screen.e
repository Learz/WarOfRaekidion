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

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_return_key_pressed: BOOLEAN; a_title, a_description, a_comment: STRING; a_resume_disabled: BOOLEAN; a_difficulty: INTEGER)
		local
			l_ticks, l_deltatime: INTEGER
			l_event: EVENT_HANDLER
			l_title, l_description, l_comment: TEXT
			l_screen: SCREEN
		do
			collection_on
			create buttons.make
			window := a_window
			create l_event.make (window)
			key_binding := a_key_binding
			must_quit := false
			is_return_key_pressed := a_is_return_key_pressed
			l_event.on_key_pressed.extend (agent manage_key)
			l_event.on_mouse_moved.extend (agent manage_mouse)
			l_event.on_mouse_pressed.extend (agent manage_click)
			create l_title.make_centered (a_title, 24, window, 0, 0, window.width, 150, [255, 255, 255], true)
			create l_description.make_centered (a_description, 16, window, 0, 25, window.width, 150, [255, 255, 255], true)
			create l_comment.make_centered (a_comment, 16, window, 0, 50, window.width, 150, [192, 192, 192], true)
			create version.make_centered (window.version, 10, window, 0, 397, window.width, 0, [96, 96, 96], false)
			version.set_y (version.y - (version.height * 2))
			resume_disabled := a_resume_disabled

			if not resume_disabled then
				buttons.extend (create {BUTTON}.make ("button", window, 100, 150, "Resume"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "Options"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 250, "End game"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 300, "Quit"))
			else
				buttons.extend (create {BUTTON}.make ("button", window, 100, 200, "End game"))
				buttons.extend (create {BUTTON}.make ("button", window, 100, 250, "Quit"))
			end

			selection := buttons.first
			button_index := 1

			if attached selection as la_selection then
				la_selection.set_image (la_selection.default_image+"_pressed")
			end

--			surface := {SDL}.sdl_creatergbsurface (0, window.width, window.height, 32, 0x00ff0000, 0x0000ff00, 0x000000ff, 0xff000000)

--			if not surface.is_default_pointer then
--				targetarea := targetarea.memory_alloc ({SDL}.sizeof_sdl_rect_struct)
--				{SDL}.set_sdl_rect_x (targetarea, 0)
--				{SDL}.set_sdl_rect_y (targetarea, 0)
--			    {SDL}.set_sdl_rect_w (targetarea, window.width)
--			    {SDL}.set_sdl_rect_h (targetarea, window.height)
--			    {SDL}.sdl_renderreadpixels (window.renderer, create {POINTER}, {SDL}.SDL_PIXELFORMAT_ARGB8888, {SDL}.get_sdl_surface_pixels (surface), {SDL}.get_sdl_surface_pitch (surface));
--				texture := {SDL}.sdl_createtexturefromsurface (window.renderer, surface)
--			end

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
				{SDL}.sdl_rendercopy (window.renderer, texture, create {POINTER}, targetarea)
				l_title.update
				l_description.update
				l_comment.update
				update
				window.render

				if options then
					l_screen := create {OPTIONS_SCREEN}.make (window, key_binding, a_difficulty, true)
					must_quit := l_screen.must_quit
					key_binding := l_screen.key_binding
					is_return_key_pressed := l_screen.is_return_key_pressed
					options := false
				end

				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end

--			{SDL}.sdl_destroytexture (texture)
--			{SDL}.sdl_freesurface (surface)
--			targetarea.memory_free
		end

feature -- Status

	resume_disabled, options: BOOLEAN

feature {NONE} -- Implementation

	targetarea, surface, texture: POINTER

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
					options := true
				elseif a_button = 3 then
					must_end := true
				elseif a_button = 4 then
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
