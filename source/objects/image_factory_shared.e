note
	description : "[
					War of Raekidion - An image factory implementation
					An {IMAGE_FACTORY_SHARED} initializes an {IMAGE_FACTORY} 
					as a singleton.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

deferred class
	IMAGE_FACTORY_SHARED

feature {NONE} -- Access

	image_factory: IMAGE_FACTORY
		-- Initialize the {IMAGE_FACTORY} only once
		once
			create result.make
		end

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
