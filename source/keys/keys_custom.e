note
	description: "Summary description for {KEYS_CUSTOM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KEYS_CUSTOM

inherit
	KEYS

feature -- Access

	move_up_key: INTEGER assign set_move_up_key
		do
			result := i_move_up_key
		end

	move_down_key: INTEGER assign set_move_down_key
		do
			result := i_move_down_key
		end

	move_left_key: INTEGER assign set_move_left_key
		do
			result := i_move_left_key
		end

	move_right_key: INTEGER assign set_move_right_key
		do
			result := i_move_right_key
		end

	accept_key: INTEGER assign set_accept_key
		do
			result := i_accept_key
		end

	return_key: INTEGER assign set_return_key
		do
			result := i_return_key
		end

	fire_key: INTEGER assign set_fire_key
		do
			result := i_fire_key
		end

	modifier_key: INTEGER assign set_modifier_key
		do
			result := i_modifier_key
		end

	action_key: INTEGER assign set_action_key
		do
			result := i_action_key
		end

	screenshot_key: INTEGER assign set_screenshot_key
		do
			result := i_screenshot_key
		end

feature -- Element change

	set_move_up_key (a_move_up_key: INTEGER)
		do
			i_move_up_key := a_move_up_key
		end

	set_move_down_key (a_move_down_key: INTEGER)
		do
			i_move_down_key := a_move_down_key
		end

	set_move_left_key (a_move_left_key: INTEGER)
		do
			i_move_left_key := a_move_left_key
		end

	set_move_right_key (a_move_right_key: INTEGER)
		do
			i_move_right_key := a_move_right_key
		end

	set_accept_key (a_accept_key: INTEGER)
		do
			i_accept_key := a_accept_key
		end

	set_return_key (a_return_key: INTEGER)
		do
			i_return_key := a_return_key
		end

	set_fire_key (a_fire_key: INTEGER)
		do
			i_fire_key := a_fire_key
		end

	set_modifier_key (a_modifier_key: INTEGER)
		do
			i_modifier_key := a_modifier_key
		end

	set_action_key (a_action_key: INTEGER)
		do
			i_action_key := a_action_key
		end

	set_screenshot_key (a_screenshot_key: INTEGER)
		do
			i_screenshot_key := a_screenshot_key
		end

feature {NONE} -- Implementation

	i_move_up_key: INTEGER
	i_move_down_key: INTEGER
	i_move_left_key: INTEGER
	i_move_right_key: INTEGER
	i_accept_key: INTEGER
	i_return_key: INTEGER
	i_fire_key: INTEGER
	i_modifier_key: INTEGER
	i_action_key: INTEGER
	i_screenshot_key: INTEGER

end
