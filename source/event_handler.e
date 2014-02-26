note
	description : "War of Raekidion - {EVENT_HANDLER} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	EVENT_HANDLER

create
	create_event_handler

feature --Initialisation de la gestion d'entrées

	event, key_pressed:POINTER

	create_event_handler
		do
			event := event.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_event_struct)
		end

	arc_tangent_2(a_y, a_x: DOUBLE):DOUBLE
	    do
			Result := {DOUBLE_MATH}.arc_tangent (a_y / a_x)
			if a_x < 0 then
				if a_y < 0 then
					Result := Result + {DOUBLE_MATH}.pi
				else
					Result := Result - {DOUBLE_MATH}.pi
				end
			end
	    end

	is_quit_event:BOOLEAN
		do
			if {SDL_WRAPPER}.get_sdl_event_type (event) = {SDL_WRAPPER}.sdl_quitevent then
				Result := True
			else
				Result := False
			end
		end

	is_key_down:BOOLEAN
		do
			if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_keydown then
				Result := true
			else
				Result := false
			end
		end

	is_key_up:BOOLEAN
		do
			if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_keyup then
				Result := true
			else
				Result := false
			end
		end

	is_mouse_down:BOOLEAN
		do
			if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_mousebuttondown then
				Result := True
			else
				Result := False
			end
		end

	is_mouse_up:BOOLEAN
		do
			if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_mousebuttonup then
				Result := True
			else
				Result := False
			end
		end

	get_mouse_x:DOUBLE
		local
			l_mouse_x:INTEGER
		do
			{SDL_WRAPPER}.get_sdl_mouse_state_noreturn ($l_mouse_x, create{POINTER})
			Result := l_mouse_x
		end

	get_mouse_y:DOUBLE
		local
			l_mouse_y:INTEGER
		do
			{SDL_WRAPPER}.get_sdl_mouse_state_noreturn (create{POINTER}, $l_mouse_y)
			Result := l_mouse_y
		end

	get_key_pressed
		do
			key_pressed := {SDL_WRAPPER}.get_sdl_keypressed(event)
		end

	is_key_esc:BOOLEAN
		do
			if key_pressed = {SDL_WRAPPER}.sdlk_escape then
				Result := True
			else
				Result := False
			end
		end

	is_key_a:BOOLEAN
		do
			if key_pressed = {SDL_WRAPPER}.sdlk_a then
				Result := True
			else
				Result := False
			end
		end

	is_key_s:BOOLEAN
		do
			if key_pressed = {SDL_WRAPPER}.sdlk_s then
				Result := True
			else
				Result := False
			end
		end

	is_key_d:BOOLEAN
		do
			if key_pressed = {SDL_WRAPPER}.sdlk_d then
				Result := True
			else
				Result := False
			end
		end

	is_key_w:BOOLEAN
		do
			if key_pressed = {SDL_WRAPPER}.sdlk_w then
				Result := True
			else
				Result := False
			end
		end

	is_key_lshift:BOOLEAN
		do
			if key_pressed = {SDL_WRAPPER}.sdlk_lshift then
				Result := True
			else
				Result := False
			end
		end

	destroy_event_handler
		do
			event.memory_free
		end

end
