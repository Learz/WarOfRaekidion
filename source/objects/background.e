note
	description : "[
					War of Raekidion - A scrolling background image
					A {BACKGROUND} is an image duplicated, then placed on top 
					of each other to create the impression of endless scrolling.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	BACKGROUND

inherit
	SPRITE
		rename
			make as sprite_make
		redefine
			update
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: INTEGER_16; a_scroll_speed: DOUBLE)
		-- Initialize `Current' from `a_name', `a_window', `a_x', `a_y' and `a_scroll_speed'
		do
			origin_y := a_y
			scroll_speed := a_scroll_speed
			sprite_make (a_name, a_window, a_x, a_y)
			if scroll_speed > 0 then
				wrapped_sprite := create {SPRITE}.make (a_name, a_window, a_x, a_y - height)
			elseif scroll_speed < 0 then
				wrapped_sprite := create {SPRITE}.make (a_name, a_window, a_x, a_y + height)
			else
				wrapped_sprite := create {SPRITE}.make (a_name, a_window, a_x, a_y)
			end
		end

feature -- Access

	update
		-- Update `Current' movement
		do
			set_y (y + scroll_speed)
			wrapped_sprite.set_y (wrapped_sprite.y + scroll_speed)
			if y >= origin_y + height then
				set_y (origin_y)
				wrapped_sprite.set_y (origin_y - height)
			elseif y <= origin_y - height then
				set_y (origin_y)
				wrapped_sprite.set_y (origin_y + height)
			end

			wrapped_sprite.update
			precursor {SPRITE}
		end

feature {NONE} -- Implementation

	scroll_speed: DOUBLE
		-- Vertical scrolling speed (can be negative)

	origin_y: INTEGER_16
		-- Original y, for reference

	wrapped_sprite: SPRITE
		-- The superposed sprite

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
