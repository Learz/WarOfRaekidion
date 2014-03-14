note
	description : "War of Raekidion - {ENTITY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	ENTITY

inherit
	SPRITE
		rename
			make as sprite_make,
			update as sprite_update
		end

create
	make

feature --Initialisation

	deltatime:REAL_64
	starttime, lasttime:INTEGER

	make(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		--Créer l'entitée
		do
			starttime := {SDL_WRAPPER}.sdl_getticks.to_integer_32
			sprite_make (a_name, a_window, a_x, a_y)
		end

	update
		local
			l_thistime: INTEGER
		do
			l_thistime := {SDL_WRAPPER}.sdl_getticks.to_integer_32 - starttime
			deltatime := l_thistime - lasttime
			lasttime := l_thistime
			sprite_update
		end

end
