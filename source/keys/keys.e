note
	description : "[
					War of Raekidion - {KEYS} class
					Interface representing all possible keys used in the game
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"


deferred class
	KEYS

feature -- Access

	move_up_key: INTEGER
		-- Key to move up
		deferred
		end

	move_down_key: INTEGER
		-- Key to move down
		deferred
		end

	move_left_key: INTEGER
		-- Key to move left
		deferred
		end

	move_right_key: INTEGER
		-- Key to move right
		deferred
		end

	accept_key: INTEGER
		-- Key to perform an accept action
		deferred
		end

	return_key: INTEGER
		-- Key to perform a return action
		deferred
		end

	fire_key: INTEGER
		-- Key to fire projectiles
		deferred
		end

	modifier_key: INTEGER
		-- Key to modify a behavior
		deferred
		end

	action_key: INTEGER
		-- Key to perform a special action
		deferred
		end

	screenshot_key: INTEGER
		-- Key to take a screenshot
		deferred
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
