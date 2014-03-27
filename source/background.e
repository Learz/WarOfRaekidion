note
	description : "War of Raekidion - {USER_INTERFACE} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


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

feature -- Initialization

	scroll_speed: DOUBLE
	origin_y: INTEGER
	wrapped_sprite: SPRITE

	make (a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER; a_scroll_speed: DOUBLE)
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

	update
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
			Precursor {SPRITE}
		end

end
