note
	description: "Summary description for {IMAGE_FACTORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IMAGE_FACTORY_SHARED

feature {NONE}

	factory:IMAGE_FACTORY
	once
		create result.make
	end
	
end
