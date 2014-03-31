note
	description : "War of Raekidion - {KEYS} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


deferred class
	KEYS

feature -- Access

	move_up_key: NATURAL_16
		deferred
		end

	move_down_key: NATURAL_16
		deferred
		end

	move_left_key: NATURAL_16
		deferred
		end

	move_right_key: NATURAL_16
		deferred
		end

	accept_key: NATURAL_16
		deferred
		end

	return_key: NATURAL_16
		deferred
		end

	fire_key: NATURAL_16
		deferred
		end

	modifier_key: NATURAL_16
		deferred
		end

	action_key: NATURAL_16
		deferred
		end

end
