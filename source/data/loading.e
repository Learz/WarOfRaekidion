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
		end

feature -- Access

	on_load: ACTION_SEQUENCE [TUPLE [resource: STRING]]
		-- The list of loading events

	loading_begin (a_resource: STRING)
		do
			on_load.call ("Loading " + a_resource + " ...")
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
