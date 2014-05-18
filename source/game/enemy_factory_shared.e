note
	description : "[
						War of Raekidion - An enemy factory implementation
						An {ENEMY_FACTORY_SHARED} initializes an {ENEMY_FACTORY} 
						as a singleton.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	ENEMY_FACTORY_SHARED

feature {NONE} -- Access

	enemy_factory: ENEMY_FACTORY
		-- Initialize the {ENEMY_FACTORY} only once
		once
			create result.make
		end

end
