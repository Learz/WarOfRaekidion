note
	description : "[
						War of Raekidion - A text input container
						A {TEXTBOX} receives text input and directly shows it 
						on top of its sprite.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXTBOX

inherit
	SPRITE
		redefine
			make,
			update
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

feature {NONE} -- Implementation

	text: TEXT
		-- The text object to render

end
