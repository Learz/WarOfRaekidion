note
	description: "Summary description for {KEYS_ARROWS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KEYS_ARROWS

inherit
	KEYS

feature -- Access

	move_up_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_up.as_natural_16
		end

	move_down_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_down.as_natural_16
		end

	move_left_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_left.as_natural_16
		end

	move_right_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_right.as_natural_16
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
			result := {SDL_WRAPPER}.sdlk_z.as_natural_16
		end

	modifier_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_x.as_natural_16
		end

	action_key: NATURAL_16
		do
			result := {SDL_WRAPPER}.sdlk_c.as_natural_16
		end

end
