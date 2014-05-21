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
			update,
			hide,
			show
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_title: STRING)
		-- Initialize `Current' from `a_name', `a_window', `a_x', `a_y' and `a_title'
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

	set_type (a_image, a_text: STRING)
		-- Changes the button image and text entirely
		do
			default_image := a_image
			set_text (a_text)
		end

feature {NONE} -- Implementation

	text: TEXT
		-- The text that will appear on top of the image

end
