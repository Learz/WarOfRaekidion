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
		end

	key_pressed:INTEGER
		do
			Result := {SDL_WRAPPER}.get_sdl_keypressed(event)
	--		on_key_pressed.call ([Result])
		end

feature -- Events identifiers

	event: POINTER

	is_quit_event:BOOLEAN
		do
			Result := {SDL_WRAPPER}.get_sdl_event_type (event) = {SDL_WRAPPER}.sdl_quitevent
		end

	is_key_down:BOOLEAN
		do
			Result := {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_keydown
		end

	is_key_up:BOOLEAN
		do
			Result := {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_keyup
		end

	is_mouse_down:BOOLEAN
		do
			Result := {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_mousebuttondown
		end

	is_mouse_up:BOOLEAN
		do
			Result := {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_mousebuttonup
		end

feature -- Mouse position

	mouse:TUPLE[x:INTEGER; y:INTEGER]
		local
			l_mouse_x, l_mouse_y: INTEGER
		do
			{SDL_WRAPPER}.get_sdl_mouse_state_noreturn ($l_mouse_x, $l_mouse_y)
			Result := [l_mouse_x, l_mouse_y]
		end

feature -- Keys identifiers

	is_key_esc:BOOLEAN
		do
			Result := key_pressed = {SDL_WRAPPER}.sdlk_escape
		end

	is_key_space:BOOLEAN
		do
			Result := key_pressed = {SDL_WRAPPER}.sdlk_space
		end

	is_key_a:BOOLEAN
		do
			Result := key_pressed = {SDL_WRAPPER}.sdlk_a
		end

	is_key_s:BOOLEAN
		do
			Result := key_pressed = {SDL_WRAPPER}.sdlk_s
		end

	is_key_d:BOOLEAN
		do
			Result := key_pressed = {SDL_WRAPPER}.sdlk_d
		end

	is_key_w:BOOLEAN
		do
			Result := key_pressed = {SDL_WRAPPER}.sdlk_w
		end

	is_key_lshift:BOOLEAN
		do
			Result := key_pressed = {SDL_WRAPPER}.sdlk_lshift
		end

	on_key_pressed:ACTION_SEQUENCE[TUPLE[key:INTEGER]]

	dispose
		do
			event.memory_free
		end

end
