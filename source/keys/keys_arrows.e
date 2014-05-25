note
	description : "[
					War of Raekidion - {KEYS_ARROWS} class
					Arcade styled key scheme using the arrow keys for movement
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

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

	screenshot_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_f12
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
