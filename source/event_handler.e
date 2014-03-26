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

feature {NONE} --Initialisation de la gestion d'entrées

	make
		do
			event := event.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_event_struct)
			create on_key_pressed
			create on_mouse_pressed
		end

feature -- Events identifiers

	check_key_pressed
		do
			if {SDL_WRAPPER}.get_sdl_event_type (event) = {SDL_WRAPPER}.sdl_keydown then
				on_key_pressed.call ([{SDL_WRAPPER}.get_sdl_keypressed (event), true])
			elseif {SDL_WRAPPER}.get_sdl_event_type (event) = {SDL_WRAPPER}.sdl_keyup then
				on_key_pressed.call ([{SDL_WRAPPER}.get_sdl_keypressed (event), false])
			end
		end

	check_mouse_pressed
		local
			l_button: NATURAL_32
			l_x, l_y: INTEGER
		do
			if {SDL_WRAPPER}.get_sdl_event_type (event) = {SDL_WRAPPER}.sdl_mousebuttondown then
				on_mouse_pressed.call ([{SDL_WRAPPER}.get_sdl_mouse_state ($l_x, $l_y), l_x, l_y, true])
			elseif {SDL_WRAPPER}.get_sdl_event_type (event) = {SDL_WRAPPER}.sdl_mousebuttonup then
				on_mouse_pressed.call ([{SDL_WRAPPER}.get_sdl_mouse_state ($l_x, $l_y), l_x, l_y, false])
			end
		end

	on_key_pressed: ACTION_SEQUENCE [TUPLE [key: INTEGER; state: BOOLEAN]]

	on_mouse_pressed: ACTION_SEQUENCE [TUPLE [button: NATURAL_32; x, y: INTEGER; state: BOOLEAN]]

	event: POINTER

	is_quit_event: BOOLEAN
		do
			Result := {SDL_WRAPPER}.get_sdl_event_type (event) = {SDL_WRAPPER}.sdl_quitevent
		end
		
	dispose
		do
			event.memory_free
		end

end
