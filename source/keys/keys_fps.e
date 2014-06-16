note
	description : "[
					War of Raekidion - {KEYS_FPS} class
					First person shooter styled key scheme using w,a,s and d for movement
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	KEYS_FPS

inherit
	KEYS

feature -- Access

	id: INTEGER = 1

	move_up_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_w
		end

	move_down_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_s
		end

	move_left_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_a
		end

	move_right_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_d
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
			result := {SDL_EVENTS}.sdlk_space
		end

	modifier_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_lshift
		end

	action_key: INTEGER
		do
			result := {SDL_EVENTS}.sdlk_e
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
