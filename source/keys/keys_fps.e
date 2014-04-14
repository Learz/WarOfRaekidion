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

	move_up_key: INTEGER
		do
			result := {SDL}.sdlk_w
		end

	move_down_key: INTEGER
		do
			result := {SDL}.sdlk_s
		end

	move_left_key: INTEGER
		do
			result := {SDL}.sdlk_a
		end

	move_right_key: INTEGER
		do
			result := {SDL}.sdlk_d
		end

	accept_key: INTEGER
		do
			result := {SDL}.sdlk_return
		end

	return_key: INTEGER
		do
			result := {SDL}.sdlk_escape
		end

	fire_key: INTEGER
		do
			result := {SDL}.sdlk_space
		end

	modifier_key: INTEGER
		do
			result := {SDL}.sdlk_lshift
		end

	action_key: INTEGER
		do
			result := {SDL}.sdlk_e
		end

end
