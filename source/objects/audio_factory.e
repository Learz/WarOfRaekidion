note
	description : "[
					War of Raekidion - An audio factory
					An {AUDIO_FACTORY} loads and stores every audio file found in 
					the game's folders and puts them in a list.
				]"
	author		: "Fran?ois Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	AUDIO_FACTORY

inherit
	LOADING
		rename
			make as loading_make
		redefine
			destroy
		end
	DIRECTORY_LIST
		rename
			make as directory_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_splash_screen: detachable SPLASH_SCREEN)
		-- Initialize `Current' from `a_splash_screen'
		require
			is_not_already_initialised: not is_init.item
				-- Ensure the factory doesn't already exist
		local
			l_directory: STRING
			l_count: INTEGER
			l_name: STRING
			l_filename_c: C_STRING
			l_filename_list: LINKED_LIST[STRING]
		do
			sounds_volume := 100
			music_volume := 100
			l_directory := "resources/sounds/"
			directory_make (l_directory)
			loading_make

			if attached a_splash_screen as la_splash then
				on_load.extend (agent la_splash.change_message)
				on_load.extend (agent la_splash.write_debug_file)
				on_debug_load.extend (agent la_splash.write_debug_file)
			end

			create sounds_list.make
			create l_filename_list.make
			l_filename_list := files_with_type ("ogg")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				loading_begin (l_filename_list.item)
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				create l_filename_c.make (l_directory + l_filename_list.item)
				sounds_list.extend ([l_name, {SDL_MIXER}.mix_load_wav (l_filename_c.item)])
				loading_done (l_filename_list.item)
				l_filename_list.forth
			end

			l_directory := "resources/music/"
			directory_make (l_directory)
			create music_list.make
			create l_filename_list.make
			l_filename_list := files_with_type ("ogg")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				loading_begin (l_filename_list.item)
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				create l_filename_c.make (l_directory + l_filename_list.item)
				music_list.extend ([l_name, {SDL_MIXER}.mix_load_music (l_filename_c.item)])
				loading_done (l_filename_list.item)
				l_filename_list.forth
			end

			on_load.wipe_out
		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		   		-- Ensure the factory is now marked as initialized
		end

feature -- Access

	sounds_volume: INTEGER
		-- Sounds (all channels) volume, ranging from 0 to 100

	music_volume: INTEGER
		-- Music volume, ranging from 0 to 100

	sound (a_name: STRING): POINTER
		-- Find a loaded sound file from `a_name'
		do
			from
				sounds_list.start
			until
				sounds_list.exhausted
			loop
				if sounds_list.item.filename.is_equal (a_name) then
					result := sounds_list.item.object
				end

				sounds_list.forth
			end
		end

	music (a_name: STRING): POINTER
		-- Find a loaded music file from `a_name'
		do
			from
				music_list.start
			until
				music_list.exhausted
			loop
				if music_list.item.filename.is_equal (a_name) then
					result := music_list.item.object
				end

				music_list.forth
			end
		end

	destroy
		-- Free every sound and music from memory
		do
			Precursor {LOADING}

			from
				sounds_list.start
			until
				sounds_list.exhausted
			loop
				{SDL_MIXER}.mix_freechunk (sounds_list.item.object)
				sounds_list.remove
			end

			from
				music_list.start
			until
				music_list.exhausted
			loop
				{SDL_MIXER}.mix_freemusic (music_list.item.object)
				music_list.remove
			end
		end

feature -- Element change

	set_music_volume (a_volume: INTEGER)
		-- Change the music channel's volume to `a_volume'
		require
			valid_volume: a_volume >= 0 and a_volume <= 100
				-- Ensure the volume is in a valid format for SDL
		do
			music_volume := a_volume
			{SDL_MIXER}.mix_volumemusic ((((music_volume ^ 2) * (10 ^ -2)) * 1.28).floor)
		ensure
			volume_set: music_volume = a_volume
				-- Ensure the volume has been changed to the desired value
		end

	set_sounds_volume (a_volume: INTEGER)
		-- Change all sounds channels' volume to `a_volume'
		require
			valid_channels: {SDL_MIXER}.mix_allocatechannels (16) /= 0
				-- Ensure the number of channels is not 0
			valid_volume: a_volume >= 0 and a_volume <= 100
				-- Ensure the volume is in a valid format for SDL
		do
			sounds_volume := a_volume

			if {SDL_MIXER}.mix_allocatechannels (16) /= 0 then
				{SDL_MIXER}.mix_volume (-1, (((sounds_volume ^ 2) * (10 ^ -2)) * 1.28).floor)
			end
		ensure
			volume_set: sounds_volume = a_volume
				-- Ensure the volume has been changed to the desired value
		end

feature {NONE} -- Implementation

	sounds_list: LINKED_LIST [TUPLE [filename: STRING; object: POINTER]]
		-- The list of sound files

	music_list: LINKED_LIST [TUPLE [filename: STRING; object: POINTER]]
		-- The list of music files

	is_init: CELL [BOOLEAN]
		-- If this class has been initialized, don't initialize it again
		once
			create result.put (false)
		end

invariant
	valid_music_volume: music_volume >= 0 and music_volume <= 100
		-- Ensure the music volume is in a valid format for SDL

	valid_sounds_volume: sounds_volume >= 0 and sounds_volume <= 100
		-- Ensure the sounds volume is in a valid format for SDL

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 Fran?ois Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
