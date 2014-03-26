note
	description : "War of Raekidion - {KEYS} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	KEYS

feature

	keymode: INTEGER

	set_keymode (a_mode: INTEGER)
		do
			keymode := a_mode \\ 2
		end

feature

	move_up_key: INTEGER
		do
			if keymode = 0 then
				Result := {SDL_WRAPPER}.sdlk_w
			else
				--Result := {SDL_WRAPPER}.sdlk_up
			end
		end

	move_down_key: INTEGER
		do
			if keymode = 0 then
				Result := {SDL_WRAPPER}.sdlk_s
			else
				--Result := {SDL_WRAPPER}.sdlk_down
			end
		end

	move_left_key: INTEGER
		do
			if keymode = 0 then
				Result := {SDL_WRAPPER}.sdlk_a
			else
				--Result := {SDL_WRAPPER}.sdlk_left
			end
		end

	move_right_key: INTEGER
		do
			if keymode = 0 then
				Result := {SDL_WRAPPER}.sdlk_d
			else
				--Result := {SDL_WRAPPER}.sdlk_right
			end
		end

	accept_key: INTEGER
		do
			if keymode = 0 then
				Result := {SDL_WRAPPER}.sdlk_space
			else
				--Result := {SDL_WRAPPER}.sdlk_enter
			end
		end

	return_key: INTEGER
		do
			Result := {SDL_WRAPPER}.sdlk_escape
		end

	modifier_key: INTEGER
		do
			if keymode = 0 then
				Result := {SDL_WRAPPER}.sdlk_lshift
			else
				--Result := {SDL_WRAPPER}.sdlk_z
			end
		end

	action_key: INTEGER
		do
			if keymode = 0 then
				Result := {SDL_WRAPPER}.sdlk_lctrl
			else
				--Result := {SDL_WRAPPER}.sdlk_x
			end
		end

end
