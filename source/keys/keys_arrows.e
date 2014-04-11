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

	move_up_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_up
		end

	move_down_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_down
		end

	move_left_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_left
		end

	move_right_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_right
		end

	accept_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_return
		end

	return_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_escape
		end

	fire_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_z
		end

	modifier_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_x
		end

	action_key: INTEGER
		do
			result := {SDL_WRAPPER}.sdlk_c
		end

end
