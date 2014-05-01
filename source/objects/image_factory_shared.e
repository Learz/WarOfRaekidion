note
	description : "[
						War of Raekidion - An image factory implementation
						An {IMAGE_FACTORY_SHARED} initializes an {IMAGE_FACTORY} 
						as a singleton.
					]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	IMAGE_FACTORY_SHARED

feature {NONE} -- Access

	image_factory: IMAGE_FACTORY
		-- Initialize the {IMAGE_FACTORY} only once
		once
			create result.make
		end

end
