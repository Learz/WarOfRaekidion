note
	description : "War of Raekidion - {ENTITY} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


class
	ENTITY

inherit
	SPRITE
	EVENT_HANDLER

create
	create_entity

feature --Initialisation

	deltatime:REAL_64
	starttime, thistime, lasttime:INTEGER

	create_entity(a_name:STRING; a_window:WINDOW; a_x, a_y:INTEGER)
		--Créer l'entitée
		do
			starttime := {SDL_WRAPPER}.sdl_getticks.to_integer_32
			create_sprite (a_name, a_window, a_x, a_y)
		end

	update_entity
		do
			thistime := {SDL_WRAPPER}.sdl_getticks.to_integer_32 - starttime
			deltatime := thistime - lasttime
			lasttime := thistime
			update_sprite
		end

	destroy_entity
		do
			destroy_sprite
		end

end
