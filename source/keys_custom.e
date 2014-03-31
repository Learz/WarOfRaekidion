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

	move_up_key: NATURAL_16 assign set_move_up_key
		do
			result := i_move_up_key
		end

	move_down_key: NATURAL_16 assign set_move_down_key
		do
			result := i_move_down_key
		end

	move_left_key: NATURAL_16 assign set_move_left_key
		do
			result := i_move_left_key
		end

	move_right_key: NATURAL_16 assign set_move_right_key
		do
			result := i_move_right_key
		end

	accept_key: NATURAL_16 assign set_accept_key
		do
			result := i_accept_key
		end

	return_key: NATURAL_16 assign set_return_key
		do
			result := i_return_key
		end

	fire_key: NATURAL_16 assign set_fire_key
		do
			result := i_fire_key
		end

	modifier_key: NATURAL_16 assign set_modifier_key
		do
			result := i_modifier_key
		end

	action_key: NATURAL_16 assign set_action_key
		do
			result := i_action_key
		end

feature -- Element change

	set_move_up_key (a_move_up_key: NATURAL_16)
		do
			i_move_up_key := a_move_up_key
		end

	set_move_down_key (a_move_down_key: NATURAL_16)
		do
			i_move_down_key := a_move_down_key
		end

	set_move_left_key (a_move_left_key: NATURAL_16)
		do
			i_move_left_key := a_move_left_key
		end

	set_move_right_key (a_move_right_key: NATURAL_16)
		do
			i_move_right_key := a_move_right_key
		end

	set_accept_key (a_accept_key: NATURAL_16)
		do
			i_accept_key := a_accept_key
		end

	set_return_key (a_return_key: NATURAL_16)
		do
			i_return_key := a_return_key
		end

	set_fire_key (a_fire_key: NATURAL_16)
		do
			i_fire_key := a_fire_key
		end

	set_modifier_key (a_modifier_key: NATURAL_16)
		do
			i_modifier_key := a_modifier_key
		end

	set_action_key (a_action_key: NATURAL_16)
		do
			i_action_key := a_action_key
		end

feature {NONE} -- Implementation

	i_move_up_key: NATURAL_16
	i_move_down_key: NATURAL_16
	i_move_left_key: NATURAL_16
	i_move_right_key: NATURAL_16
	i_accept_key: NATURAL_16
	i_return_key: NATURAL_16
	i_fire_key: NATURAL_16
	i_modifier_key: NATURAL_16
	i_action_key: NATURAL_16

end
