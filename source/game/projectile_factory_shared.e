note
	description : "[
						War of Raekidion - An enemy factory implementation
						A {PROJECTILE_FACTORY_SHARED} initializes a {PROJECTILE_FACTORY} 
						as a singleton.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	PROJECTILE_FACTORY_SHARED

feature {NONE} -- Access

	projectile_factory: PROJECTILE_FACTORY
		-- Initialize the {PROJECTILE_FACTORY} only once
		once
			create result.make
		end

end
