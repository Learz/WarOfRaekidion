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
		end

feature -- Access

	title: STRING

	update
		do
			precursor {SPRITE}
			-- Font rendering
		end

end
