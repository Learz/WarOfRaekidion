note
	description : "War of Raekidion - {EVENT_HANDLER} class"
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

	make
		do
			event := event.memory_alloc ({SDL}.sizeof_sdl_event_struct)
			create on_typing
			create on_key_pressed
			create on_mouse_moved
			create on_mouse_pressed
		end

feature -- Access

	on_typing: ACTION_SEQUENCE [TUPLE [keyname: STRING]]
	on_key_pressed: ACTION_SEQUENCE [TUPLE [key: INTEGER_32; state: BOOLEAN]]
	on_mouse_moved: ACTION_SEQUENCE [TUPLE [x, y: INTEGER_32]]
	on_mouse_pressed: ACTION_SEQUENCE [TUPLE [button: NATURAL_32; x, y: INTEGER_32; state: BOOLEAN]]

	manage_event
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
		do
			result := {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_quitevent
		end

feature {NONE} -- Implementation

	event: POINTER

	check_key_typed
		local
			l_c_string: C_STRING
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_keydown then
				create l_c_string.make_by_pointer ({SDL_EVENTS}.get_sdl_key_name ({SDL_EVENTS}.get_sdl_keypressed (event)))
				on_typing.call ([l_c_string.string])
			end
		end

	check_key_pressed
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_keydown then
				on_key_pressed.call ([{SDL_EVENTS}.get_sdl_keypressed (event), true])
			elseif {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_keyup then
				on_key_pressed.call ([{SDL_EVENTS}.get_sdl_keypressed (event), false])
			end
		end

	check_mouse_moved
		local
			l_x, l_y: INTEGER_32
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_mousemotion then
				{SDL_EVENTS}.get_sdl_mouse_state_noreturn ($l_x, $l_y)
				on_mouse_moved.call ([(l_x / 2).floor, (l_y / 2).floor])
			end
		end

	check_mouse_pressed
		local
			l_x, l_y: INTEGER_32
			l_button: NATURAL_32
		do
			if {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_mousebuttondown then
				l_button := {SDL_EVENTS}.get_sdl_mouse_state ($l_x, $l_y)
				on_mouse_pressed.call ([l_button, (l_x / 2).floor, (l_y / 2).floor, true])
			elseif {SDL_EVENTS}.get_sdl_event_type (event) = {SDL_EVENTS}.sdl_mousebuttonup then
				l_button := {SDL_EVENTS}.get_sdl_mouse_state ($l_x, $l_y)
				on_mouse_pressed.call ([l_button, (l_x / 2).floor, (l_y / 2).floor, false])
			end
		end

	dispose
		do
			event.memory_free
		end

end
