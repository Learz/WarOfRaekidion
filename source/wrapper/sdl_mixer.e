note
	description: "Summary description for {SDL_MIXER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SDL_MIXER

feature -- Fonctions

	frozen mix_init (a_flags: INTEGER): INTEGER
		external
			"C (int) : int | <SDL_mixer.h>"
		alias
			"Mix_Init"
		end

	frozen mix_init_noreturn (a_flags: INTEGER)
		external
			"C (int)| <SDL_mixer.h>"
		alias
			"Mix_Init"
		end

	frozen mix_open_audio(a_frequency: INTEGER; a_format: NATURAL_16; a_channels: INTEGER; a_chunksize: INTEGER) : INTEGER
		external
			"C (int, Uint16, int, int) : int | <SDL_mixer.h>"
		alias
			"Mix_OpenAudio"
		end

	frozen mix_open_audio_noreturn(a_frequency: INTEGER; a_format: NATURAL_16; a_channels: INTEGER; a_chunksize: INTEGER)
		external
			"C (int, Uint16, int, int) | <SDL_mixer.h>"
		alias
			"Mix_OpenAudio"
		end

	frozen mix_load_wav(a_file: POINTER) : POINTER
		external
			"C (const char*) : Mix_Chunk* | <SDL_mixer.h>"
		alias
			"Mix_LoadWAV"
		end

	frozen mix_allocatechannels(a_numchans: INTEGER): INTEGER
		external
			"C (int): int | <SDL_mixer.h>"
		alias
			"Mix_AllocateChannels"
		end

	frozen mix_volumechunk(a_chunk: POINTER; volume: INTEGER)--: INTEGER
		external
			"C (Mix_Chunk*, int)| <SDL_mixer.h>" --Add int
		alias
			"Mix_VolumeChunk"
		end

	frozen Mix_Volume(a_channel: INTEGER; volume: INTEGER): INTEGER
		external
			"C (int, int) : int | <SDL_mixer.h>"
		alias
			"Mix_Volume"
		end

	frozen Mix_PlayChannel(a_channel: INTEGER; a_chunk: POINTER; a_loops: INTEGER) : INTEGER
		external
			"C (int, Mix_Chunk*, int) : int | <SDL_mixer.h>"
		alias
			"Mix_PlayChannel"
		end

	frozen mix_freechunk(chunk: POINTER)
		external
			"C (Mix_Chunk*) | <SDL_mixer.h>"
		alias
			"Mix_FreeChunk"
		end

	frozen mix_quit
		external
			"C () | <SDL_mixer.h>"
		alias
			"Mix_Quit"
		end

	frozen mix_close_audio
		external
			"C () | <SDL_mixer.h>"
		alias
			"Mix_CloseAudio"
		end

feature -- Constantes

	frozen mix_init_ogg: INTEGER

		external
			"C inline use <SDL_mixer.h>"
		alias
			"MIX_INIT_OGG"
		end

	frozen mix_default_format: NATURAL_16

		external
			"C inline use <SDL_mixer.h>"
		alias
			"MIX_DEFAULT_FORMAT"
		end

end
