note
	description: "Summary description for {AUDIO_FACTORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUDIO_FACTORY_SHARED

feature {NONE} -- Access

	chunk, music: POINTER

	audio_factory: AUDIO_FACTORY
		once
			create result.make
		end

	play_sound (a_name: STRING; a_channel: INTEGER)
		do
			chunk := audio_factory.chunk (a_name)

			if chunk.is_default_pointer then
				io.put_string ("Audio file not found")
			else
				{SDL_MIXER}.mix_volumechunk (chunk, 128)
				{SDL_MIXER}.mix_playchannel (a_channel, chunk, 0)
			end
		end

	stop_sound (a_channel: INTEGER)
		do
			{SDL_MIXER}.mix_haltchannel (a_channel)
		end

	play_music (a_name: STRING; a_loops: INTEGER)
		do
			music := audio_factory.music (a_name)

			if music.is_default_pointer then
				io.put_string ("Audio file not found")
			else
				{SDL_MIXER}.mix_volumemusic (128)
				{SDL_MIXER}.mix_playmusic (music, -1)
			end
		end

	stop_music
		do
			{SDL_MIXER}.mix_haltmusic
		end

end
