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
			result := {SDL_EVENTS}.sdlk_up
		end

	move_down_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_down
		end

	move_left_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_left
		end

	move_right_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_right
		end

	accept_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_return
		end

	return_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_escape
		end

	fire_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_x
		end

	modifier_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_z
		end

	action_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_c
		end

end
