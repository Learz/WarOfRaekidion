note
	description: "Summary description for {ENTITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENTITY

inherit
	SPRITE
	EVENT_HANDLER

create
	create_entity

feature --Initialisation

	deltatime:REAL_64
	starttime,thistime,lasttime,x,y:INTEGER
	window:WINDOW


	create_entity(spritename:STRING;imgwindow:WINDOW;posx,posy:INTEGER)
	--Cr�er l'entit�e
	do
		window:=imgwindow
		starttime:={SDL_WRAPPER}.sdl_getticks().to_integer_32
		x := posx
		y := posy
		create_sprite(spritename,window,x,y)
	end

	update_entity()

	do
		thistime:={SDL_WRAPPER}.sdl_getticks().to_integer_32 - starttime
		deltatime:= thistime-lasttime
		lasttime:= thistime
		update_sprite()
	end

	destroy_entity()

	do
		destroy_sprite()
	end

end
