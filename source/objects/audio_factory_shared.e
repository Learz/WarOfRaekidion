note
	description : "[
						War of Raekidion - An audio factory implementation
						An {AUDIO_FACTORY_SHARED} initializes an {AUDIO_FACTORY} 
						as a singleton.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	AUDIO_FACTORY_SHARED

feature {NONE} -- Access

	sound: POINTER
		-- Current sound file loaded

	music: POINTER
		-- Current music file loaded

	audio_factory: AUDIO_FACTORY
		-- Initialize the {AUDIO_FACTORY} only once
		once
			create result.make
		end

	play_sound (a_name: STRING; a_channel: INTEGER)
		-- Play sound `a_name' on `a_channel'
		do
			sound := audio_factory.sound (a_name)

			if sound.is_default_pointer then
--				io.put_string ("Audio file not found: "+a_name)
			else
				{SDL_MIXER}.mix_playchannel (a_channel, sound, 0)
			end
		end

	stop_sound (a_channel: INTEGER)
		-- Stop all sounds on `a_channel'
		do
			{SDL_MIXER}.mix_haltchannel (a_channel)
		end

	play_music (a_name: STRING; a_loops: INTEGER)
		-- Play music `a_name' with `a_loops' (0 for none, -1 for infinite)
		do
			music := audio_factory.music (a_name)

			if music.is_default_pointer then
--				io.put_string ("Audio file not found: "+a_name)
			else
				{SDL_MIXER}.mix_playmusic (music, -1)
			end
		end

	stop_music
		-- Stop all music
		do
			{SDL_MIXER}.mix_haltmusic
		end

end
