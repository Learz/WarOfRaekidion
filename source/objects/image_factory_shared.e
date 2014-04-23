note
	description : "War of Raekidion - {IMAGE_FACTORY_SHARED} class"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date$"
	revision	: "$Revision$"


deferred class
	IMAGE_FACTORY_SHARED

feature {NONE} -- Access

	image_factory: IMAGE_FACTORY
		once
			create result.make
		end

end
