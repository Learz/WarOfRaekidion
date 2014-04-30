note
	description : "[
						War of Raekidion - A clickable and selectable button
						A {BUTTON} is an hoverable and image changing 
						sprite which acts as a simple event trigger.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BUTTON

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

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_title: STRING)
		-- Initialize `Current'
		do
			sprite_make (a_name, a_window, a_x, a_y)
			create text.make_centered (a_title, 16, a_window, x, y, width, height, [192, 192, 255], true)
		end

feature -- Access

	update
		-- Update `Current' text and image
		do
			precursor {SPRITE}
			text.update
		end

feature -- Element change

	recenter
		-- Replaces the text in the center
		do
			text.recenter
		end

	set_text (a_text: STRING)
		-- Replaces the text with `a_text'
		do
			text.set_text (a_text, text.size)
		end

feature {NONE} -- Implementation

	text: TEXT
		-- The text that will appear on top of the image

end
