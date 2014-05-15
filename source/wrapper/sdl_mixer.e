note
	description : "War of Raekidion - {SDL_MIXER} is a wrapper for the C library SDL2_mixer."
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

class
	SDL_MIXER

feature -- Fonctions

	frozen mix_init (a_flags: INTEGER): INTEGER
		-- Initialize the mixer by loading support as indicated by the flags.
		external
			"C (int) : int | <SDL_mixer.h>"
		alias
			"Mix_Init"
		end

	frozen mix_init_noreturn (a_flags: INTEGER)
	    -- Initialize the mixer by loading support as indicated by the flags, returns nothing.
		external
			"C (int)| <SDL_mixer.h>"
		alias
			"Mix_Init"
		end

	frozen mix_open_audio(a_frequency: INTEGER; a_format: NATURAL_16; a_channels: INTEGER; a_chunksize: INTEGER) : INTEGER
		-- Initialize the mixer API.
		external
			"C (int, Uint16, int, int) : int | <SDL_mixer.h>"
		alias
			"Mix_OpenAudio"
		end

	frozen mix_open_audio_noreturn(a_frequency: INTEGER; a_format: NATURAL_16; a_channels: INTEGER; a_chunksize: INTEGER)
		-- Initialize the mixer API, returns nothing.
		external
			"C (int, Uint16, int, int) | <SDL_mixer.h>"
		alias
			"Mix_OpenAudio"
		end

	frozen mix_load_wav(a_file: POINTER) : POINTER
		-- Load `a_file' for use as a sample.
		external
			"C (const char*) : Mix_Chunk* | <SDL_mixer.h>"
		alias
			"Mix_LoadWAV"
		end

	frozen mix_load_music(a_file: POINTER) : POINTER
		-- Load `a_file' for use as music.
		external
			"C (const char*) : Mix_Music* | <SDL_mixer.h>"
		alias
			"Mix_LoadMUS"
		end

	frozen mix_allocatechannels(a_numchans: INTEGER): INTEGER
		-- Set `a_numchans' channels to be mixed.
		external
			"C (int) : int | <SDL_mixer.h>"
		alias
			"Mix_AllocateChannels"
		end

	frozen mix_volume(a_channel, volume: INTEGER)
		external
			"C (int, int) | <SDL_mixer.h>"
		alias
			"Mix_Volume"
		end

	frozen mix_getvolume(a_channel, volume: INTEGER): INTEGER
		-- Set `volume' for `a_channel'
		external
			"C (int, int): int | <SDL_mixer.h>"
		alias
			"Mix_Volume"
		end

	frozen mix_volumemusic(volume: INTEGER)
		-- Set `volume' for the music
		external
			"C (int) | <SDL_mixer.h>"
		alias
			"Mix_VolumeMusic"
		end

	frozen mix_getvolumemusic(volume: INTEGER): INTEGER
		-- Volume of the music
		external
			"C (int): int | <SDL_mixer.h>"
		alias
			"Mix_VolumeMusic"
		end

	frozen Mix_PlayChannel(a_channel: INTEGER; a_chunk: POINTER; a_loops: INTEGER)
		-- Play `a_chunk' on `a_channel'
		-- If `a_channel' is -1, pick the first free unreserved channel.
		external
			"C (int, Mix_Chunk*, int) | <SDL_mixer.h>"
		alias
			"Mix_PlayChannel"
		end

	frozen Mix_PlayMusic(a_music: POINTER; a_loops: INTEGER)
		-- Play `a_music' `a_loop' times through from start to finish.
		external
			"C (Mix_Music*, int) | <SDL_mixer.h>"
		alias
			"Mix_PlayMusic"
		end

	frozen Mix_HaltChannel(a_channel: INTEGER)
		-- Halt `a_channel' playback, or all channels if -1 is passed in.
		external
			"C (int) | <SDL_mixer.h>"
		alias
			"Mix_HaltChannel"
		end

	frozen Mix_HaltMusic
		-- Halt the music
		external
			"C | <SDL_mixer.h>"
		alias
			"Mix_HaltMusic"
		end

	frozen mix_freechunk(a_chunk: POINTER)
		-- Free the memory used in `a_chunk', and free `a_chunk' itself as well.
		external
			"C (Mix_Chunk*) | <SDL_mixer.h>"
		alias
			"Mix_FreeChunk"
		end

	frozen mix_freemusic(a_music: POINTER)
		-- Free the loaded `a_music'.
		external
			"C (Mix_Music*) | <SDL_mixer.h>"
		alias
			"Mix_FreeMusic"
		end

	frozen mix_quit
		-- Clean up all dynamically loaded library handles.
		external
			"C () | <SDL_mixer.h>"
		alias
			"Mix_Quit"
		end

	frozen mix_close_audio
		-- Shutdown and cleanup the mixer API.
		external
			"C () | <SDL_mixer.h>"
		alias
			"Mix_CloseAudio"
		end

feature -- Constantes

	frozen mix_init_ogg: INTEGER
		-- Flag to support ogg Vorbis
		external
			"C inline use <SDL_mixer.h>"
		alias
			"MIX_INIT_OGG"
		end

	frozen mix_default_format: NATURAL_16
		-- Flag for signed 16-bit samples in system byte order format
		external
			"C inline use <SDL_mixer.h>"
		alias
			"MIX_DEFAULT_FORMAT"
		end

end
