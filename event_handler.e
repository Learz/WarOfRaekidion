note
	description: "Summary description for {EVENT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_HANDLER



create
	create_event_handler

feature --Initialisation de la gestion d'entrées

	event,keypressed:POINTER

	create_event_handler()
	do
		event:=event.memory_alloc ({SDL_WRAPPER}.sizeof_sdl_event_struct)
	end

	arc_tangent_2(y, x: DOUBLE):DOUBLE
    do
       Result := {DOUBLE_MATH}.arc_tangent(y/x)
       if x < 0 then
          if y < 0 then
             Result := Result + {DOUBLE_MATH}.pi
          else
             Result := Result - {DOUBLE_MATH}.pi
          end
       end
    end

	is_quitevent:BOOLEAN
	do
		if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_quitevent then
			Result:=True
		else
			Result:=False
		end
	end

	is_keydown:BOOLEAN
	do
		if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_keydown then
			Result:=true
		else
			Result:=false
		end
	end

	is_keyup:BOOLEAN
	do
		if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_keyup then
			Result:=true
		else
			Result:=false
		end
	end

	is_mousedown:BOOLEAN
	do
		if {SDL_WRAPPER}.get_sdl_event_type(event) = {SDL_WRAPPER}.sdl_mousebuttondown then
			Result:=True
		else
			Result:=False
		end
	end

	get_mouse_x:DOUBLE
	local
		mouse_x:INTEGER
	do
		{SDL_WRAPPER}.get_sdl_mouse_state_noreturn($mouse_x,create{POINTER})
		Result:=mouse_x
	end

	get_mouse_y:DOUBLE
	local
		mouse_y:INTEGER
	do
		{SDL_WRAPPER}.get_sdl_mouse_state_noreturn(create{POINTER},$mouse_y)
		Result:=mouse_y
	end

	get_keypressed()
	do
		keypressed:={SDL_WRAPPER}.get_sdl_keypressed(event)
	end

	is_key_esc:BOOLEAN
	do
		if keypressed={SDL_WRAPPER}.sdlk_escape then
			Result:=True
		else
			Result:=False
		end
	end

	is_key_a:BOOLEAN
	do
		if keypressed={SDL_WRAPPER}.sdlk_a then
			Result:=True
		else
			Result:=False
		end
	end

	is_key_s:BOOLEAN
	do
		if keypressed={SDL_WRAPPER}.sdlk_s then
			Result:=True
		else
			Result:=False
		end
	end

	is_key_d:BOOLEAN
	do
		if keypressed={SDL_WRAPPER}.sdlk_d then
			Result:=True
		else
			Result:=False
		end
	end

	is_key_w:BOOLEAN
	do
		if keypressed={SDL_WRAPPER}.sdlk_w then
			Result:=True
		else
			Result:=False
		end
	end

	is_key_lshift:BOOLEAN
	do
		if keypressed={SDL_WRAPPER}.sdlk_lshift then
			Result:=True
		else
			Result:=False
		end
	end

	destroy_event_handler()
	do
		event.memory_free
	end

end
