note
	description: "Summary description for {IMAGE_FACTORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IMAGE_FACTORY_SHARED

feature {NONE}

	factory:IMAGE_FACTORY
	require
		renderer_not_null: not renderer.is_default_pointer
	once
		create result.make (renderer)
	end

	renderer:POINTER assign set_renderer

	set_renderer(a_renderer:POINTER)
		do
			renderer:=a_renderer
		end

end
