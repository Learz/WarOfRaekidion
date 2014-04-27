note
	description: "Summary description for {BUTTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
		do
			title := a_title
			sprite_make (a_name, a_window, a_x, a_y)
			create text.make_centered (a_title, 16, a_window, x, y, width, height, [192, 192, 255], true)
		end

feature -- Access

	title: STRING

	update
		do
			precursor {SPRITE}
			text.update
		end

feature -- Element change

	recenter
		do
			text.recenter
		end

	set_text (a_text: STRING)
		do
			text.set_text (a_text, text.size)
		end

feature {NONE} -- Implementation

	text: TEXT

end
