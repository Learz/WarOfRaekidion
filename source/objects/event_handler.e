note
	description : "[
						War of Raekidion - Events handler
						A {EVENT_HANDLER} looks for keyboard and mouse events 
						and sends them to action sequences to use with agents.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EVENT_HANDLER

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW)
		-- Initialize `Current'
		do
			window := a_window
			event := event.memory_alloc ({SDL}.sizeof_sdl_event_struct)
			create on_typing
			create on_key_pressed
			create on_mouse_moved
			create on_mouse_pressed
		end

feature -- Access

	on_typing: ACTION_SEQUENCE [TUPLE [keyname: STRING]]
		-- Characters typed on the keyboard, by their name

	on_key_pressed: ACTION_SEQUENCE [TUPLE [key: INTEGER_32; state: BOOLEAN]]
		-- Keys pressed on the keyboard, by their keycode and state (up or down)

	on_mouse_moved: ACTION_SEQUENCE [TUPLE [x, y: INTEGER_32]]
		-- Position of the mouse everytime it is moved

	on_mouse_pressed: ACTION_SEQUENCE [TUPLE [button: NATURAL_32; x, y: INTEGER_32; state: BOOLEAN]]
		-- Position, button and state of the button of the mouse everytime a button is pressed

	manage_event
		-- Event checkup
		local
			l_must_quit: INTEGER
		do
			from
				l_must_quit := {SDL_EVENTS}.sdl_pollevent (event)
			until
				l_must_quit = 0
			loop
				check_key_typed
				check_key_pressed
				check_mouse_moved
				check_mouse_pressed
				l_must_quit := {SDL_EVENTS}.sdl_pollevent (event)
			end
		end

	is_quit_event: BOOLEAN
		-- If the event is a kill signal
		do
			result := {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_quitevent
		end

feature {NONE} -- Implementation

	event: POINTER
		-- The event object to handle

	window: WINDOW
		-- The window in which to handle events

	check_key_typed
		-- Check any key typed and get their name
		local
			l_c_string: C_STRING
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_keydown then
				create l_c_string.make_by_pointer ({SDL_EVENTS}.get_sdl_key_name ({SDL_EVENTS}.get_sdl_keypressed (event)))
				on_typing.call ([l_c_string.string])
			end
		end

	check_key_pressed
		-- Check any key pressed or released and get their keycode and state
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_keydown then
				on_key_pressed.call ([{SDL_EVENTS}.get_sdl_keypressed (event), true])
			elseif {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_keyup then
				on_key_pressed.call ([{SDL_EVENTS}.get_sdl_keypressed (event), false])
			end
		end

	check_mouse_moved
		-- Check mouse position if it has moved
		local
			l_x, l_y: INTEGER_32
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_mousemotion then
				{SDL_EVENTS}.get_sdl_mouse_state_noreturn ($l_x, $l_y)
				on_mouse_moved.call ([(l_x / window.scale).floor, (l_y / window.scale).floor])
			end
		end

	check_mouse_pressed
		-- Check any mouse button pressed, its state and mouse position
		local
			l_x, l_y: INTEGER_32
			l_button: NATURAL_32
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_mousebuttondown then
				l_button := {SDL_EVENTS}.get_sdl_mouse_state ($l_x, $l_y)
				on_mouse_pressed.call ([l_button, (l_x / window.scale).floor, (l_y / window.scale).floor, true])
			elseif {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_mousebuttonup then
				l_button := {SDL_EVENTS}.get_sdl_mouse_state ($l_x, $l_y)
				on_mouse_pressed.call ([l_button, (l_x / window.scale).floor, (l_y / window.scale).floor, false])
			end
		end

	dispose
		-- Free the event from memory
		do
			event.memory_free
		end

end
