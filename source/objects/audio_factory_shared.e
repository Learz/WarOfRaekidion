note
	description: "Summary description for {AUDIO_FACTORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUDIO_FACTORY_SHARED

feature {NONE} -- Access

	audio_factory: AUDIO_FACTORY
		once
			create Result.make
		end

end
