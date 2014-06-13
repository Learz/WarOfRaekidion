note
	description: "Summary description for {CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION

inherit
	XML_DOCUMENT_PARSER

create
	make

feature -- Access

	window_scale: DOUBLE assign set_window_scale

	keybind: INTEGER assign set_keybind

	difficulty: INTEGER assign set_difficulty

	music_volume: INTEGER assign set_music_volume

	sounds_volume: INTEGER assign set_sounds_volume

	save (a_filename: STRING)
		do
			save_document (a_filename)
		end

	load (a_filename: STRING)
		local
			l_directory: DIRECTORY
		do
			create l_directory.make_with_name (".")

			if l_directory.has_entry (a_filename) then
				parse_from_filename (a_filename)
				read_configuration
			else
				document.set_xml_declaration (create {XML_DECLARATION}.make_in_document (document, "1.0", "UTF-8", false))
				document.set_root_element (create {XML_ELEMENT}.make_root (document, "config", create {XML_NAMESPACE}.make_default))
				set_window_scale (1.5)
				set_keybind (1)
				set_difficulty (2)
				set_music_volume (128)
				set_sounds_volume (128)
				save (a_filename)
			end
		end

feature -- Element change

	set_window_scale (a_value: DOUBLE)
		do
			window_scale := a_value
			modify_node ("scale", a_value.out)
		end

	set_keybind (a_value: INTEGER)
		do
			keybind := a_value
			modify_node ("keybind", a_value.out)
		end

	set_difficulty (a_value: INTEGER)
		do
			difficulty := a_value
			modify_node ("difficulty", a_value.out)
		end

	set_music_volume (a_value: INTEGER)
		do
			music_volume := a_value
			modify_node ("music", a_value.out)
		end

	set_sounds_volume (a_value: INTEGER)
		do
			sounds_volume := a_value
			modify_node ("sound", a_value.out)
		end

feature {NONE} -- Implementation

	read_configuration
		do
			if attached process_node ("scale") as la_element and then attached la_element.text as la_value and then la_value.is_double then
				window_scale := la_value.to_double
			else
				set_window_scale (1.5)
			end

			if attached process_node ("keybind") as la_element and then attached la_element.text as la_value and then la_value.is_integer then
				keybind := la_value.to_integer
			else
				set_keybind (1)
			end

			if attached process_node ("difficulty") as la_element and then attached la_element.text as la_value and then la_value.is_integer then
				difficulty := la_value.to_integer
			else
				set_difficulty (2)
			end

			if attached process_node ("music") as la_element and then attached la_element.text as la_value and then la_value.is_integer then
				music_volume := la_value.to_integer
			else
				set_music_volume (128)
			end

			if attached process_node ("sound") as la_element and then attached la_element.text as la_value and then la_value.is_integer then
				sounds_volume := la_value.to_integer
			else
				set_sounds_volume (128)
			end
		end

end
