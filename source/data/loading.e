note
	description: "Summary description for {LOADING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOADING

create
	make

feature {NONE} -- Initialization

	make
		do
			create on_load
			create on_debug_load
		end

feature -- Status

	cheat_mode: BOOLEAN
		-- True if mods have been added or base files have been modified

feature -- Access

	on_load: ACTION_SEQUENCE [TUPLE [resource: STRING]]
		-- The list of loading events

	on_debug_load: ACTION_SEQUENCE [TUPLE [resource: STRING]]
		-- The list of debug loading events

	loading_begin (a_resource: STRING)
		do
			on_load.call ("Loading " + a_resource + " ...")
		end

	loading_check (a_source: PLAIN_TEXT_FILE; a_hash: STRING): BOOLEAN
		local
			l_hash: MD5
			l_result: STRING
			l_equals: BOOLEAN
		do
        	create l_hash.make
        	a_source.open_read
        	a_source.read_stream (a_source.count)
        	l_hash.update_from_string (a_source.last_string)
        	l_result := l_hash.digest_as_string
        	l_equals := l_result.is_equal (a_hash)
        	on_debug_load.call ("File " + a_source.path.name.out + " has an MD5 checksum of " + l_result)

        	if not l_equals then
        		on_debug_load.call ("Error: " + a_source.path.name.out + " has been modified. The game will now launch with highscores disabled.")
        	end

        	Result := l_equals
		end

	loading_error (a_resource: STRING)
		do
			on_load.call ("Error loading " + a_resource + ".")
		end

	loading_done (a_resource: STRING)
		do
			on_load.call ("Loading " + a_resource + " ... DONE")
		end

	destroy
		-- Destroy events
		do
			on_load.wipe_out
		end

end
