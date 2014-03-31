note
	description: "Summary description for {KEYS_FPS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KEYS_FPS

inherit
	KEYS

feature -- Access

	move_up_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_w.as_natural_16
		end

	move_down_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_s.as_natural_16
		end

	move_left_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_a.as_natural_16
		end

	move_right_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_d.as_natural_16
		end

	accept_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_return.as_natural_16
		end

	return_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_escape.as_natural_16
		end

	fire_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_space.as_natural_16
		end

	modifier_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_lshift.as_natural_16
		end

	action_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_e.as_natural_16
		end

end
