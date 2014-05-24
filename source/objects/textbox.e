note
	description : "[
					War of Raekidion - A text input container
					A {TEXTBOX} receives text input and directly shows it 
					on top of its sprite.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

class
	TEXTBOX

inherit
	SPRITE
		redefine
			make,
			update,
			hide,
			show
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE)
		-- Initialize `Current' from `a_name', `a_window', `a_x' and `a_y'
		do
			precursor {SPRITE} (a_name, a_window, a_x, a_y)
			create text.make_empty (a_window, a_x, a_y, [0, 0, 0], false)
			create char_string.make_empty
		end

feature -- Access

	char_string: STRING
		-- Character sequence to display

	update
		-- Update `Current' on screen
		do
			precursor {SPRITE}
			text.set_text (char_string, 16)

			if char_string.count > 0 then
				text.set_x ((width / 2) + x - (text.width / 2))
				text.set_y ((height / 2) + y - (text.height / 2))
			end

			text.update
		end

feature -- Element change

	hide
		-- Make `Current' disapear on screen
		do
			text.hide
			Precursor {SPRITE}
		end

	show
		-- Make `Current' visible on screen
		do
			text.show
			Precursor {SPRITE}
		end

feature {NONE} -- Implementation

	text: TEXT
		-- The text object to render

end
