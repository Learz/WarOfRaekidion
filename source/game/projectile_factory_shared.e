note
	description: "Summary description for {ENEMY_FACTORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROJECTILE_FACTORY_SHARED

feature {NONE} -- Access

	projectile_factory: PROJECTILE_FACTORY
		once
			create result.make
		end

end
