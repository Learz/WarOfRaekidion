note
	description: "Summary description for {AUDIO_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUDIO_FACTORY

inherit
	DIRECTORY_LIST
		rename
			make as directory_make
		end

create make

feature {NONE} -- Initialization

	make
		require
			is_not_already_initialised: not is_init.item
		local
			l_directory: STRING
			l_count: INTEGER
			l_name: STRING
			l_filename_c: C_STRING
			l_filename_list: LINKED_LIST[STRING]
		do
			l_directory := "resources/sounds/"
			directory_make (l_directory)
			create sounds_list.make
			create l_filename_list.make
			l_filename_list := list_files ("ogg")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				create l_filename_c.make (l_directory + l_filename_list.item)
				sounds_list.extend ([l_name, {SDL_MIXER}.mix_load_wav (l_filename_c.item)])
				l_filename_list.forth
			end

			l_directory := "resources/music/"
			directory_make (l_directory)
			create music_list.make
			create l_filename_list.make
			l_filename_list := list_files ("ogg")

			from
				l_filename_list.start
			until
				l_filename_list.exhausted
			loop
				l_count := l_filename_list.item.index_of ('.', 1)
				l_name := l_filename_list.item.substring (1, l_count - 1)
				create l_filename_c.make (l_directory + l_filename_list.item)
				music_list.extend ([l_name, {SDL_MIXER}.mix_load_music (l_filename_c.item)])
				l_filename_list.forth
			end

		    is_init.replace (true)
		ensure
		   	is_initialised: is_init.item
		end

feature -- Access

	chunk (a_name: STRING): POINTER
		local
			l_count: NATURAL_16
			l_name: STRING
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
		local
			l_count: NATURAL_16
			l_name: STRING
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

	dispose
		do
			from
				sounds_list.start
			until
				sounds_list.exhausted
			loop
				{SDL_MIXER}.mix_freechunk (sounds_list.item.object)
				sounds_list.forth
			end

			from
				music_list.start
			until
				music_list.exhausted
			loop
				{SDL_MIXER}.mix_freemusic (music_list.item.object)
				music_list.forth
			end
		end

feature {NONE} -- Implementation

	sounds_list: LINKED_LIST[TUPLE[filename: STRING; object: POINTER]]
	music_list: LINKED_LIST[TUPLE[filename: STRING; object: POINTER]]

	is_init: CELL[BOOLEAN]
		once
			create result.put (false)
		end

end
