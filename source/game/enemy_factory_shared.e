note
	description: "Summary description for {ENEMY_FACTORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENEMY_FACTORY_SHARED

feature {NONE} -- Access

	enemy_factory: ENEMY_FACTORY
		once
			create result.make
		end

end
