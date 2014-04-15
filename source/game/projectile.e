note
	description: "Summary description for {PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECTILE

inherit
	ENTITY
		rename
			make as entity_make
		redefine
			update
		end
	AUDIO_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_window: WINDOW; a_x, a_y: DOUBLE; a_owner: BOOLEAN)
		do
			owner := a_owner
			nb_channels :={SDL_MIXER}.mix_allocatechannels (16)
			last_volume :={SDL_MIXER}.mix_volume (-1, 100)
			set_sound
			entity_make (a_name, a_window, a_x, a_y, 1)
		end

feature -- Access

	owner: BOOLEAN
	audiofactory: AUDIO_FACTORY
	chunk: POINTER
	channel_log, last_volume, nb_channels: INTEGER

	update
		do
			if
				y < -height or
				y > (window.height + height) or
				x < -width or
				x > (window.width + width)
			then
				destroy
			end

			angle := trajectory.angle - 90
			precursor {ENTITY}
		end

	set_sound
		do
			audiofactory := audio_factory
			chunk := audiofactory.chunk ("laser")
			if chunk.is_default_pointer then
				io.put_string ("Audio file not found")
			else
				{SDL_MIXER}.mix_volumechunk (chunk, 128)
				channel_log:= {SDL_MIXER}.mix_playchannel (-1, chunk, 0)
				--io.put_integer (channel_log)
			end
		end

end
