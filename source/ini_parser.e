note
	description: "War of Raekidion - {INI_PARSER} class"
	author: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date: "$Date$"
	revision: "$Revision$"

class
	INI_PARSER

create
	load_file

feature {NONE}

	load_file(a_path:STRING)
		do
			create file.make (a_path)
			if not file.exists then
				print ("error: '" + a_path + "' does not exist%N")
			else
				if not file.is_readable then
					print ("error: '" + a_path + "' is not readable.%N")
				else
					file.open_read
				end
			end
		end

feature

	file: PLAIN_TEXT_FILE

	read_property(a_name:STRING):STRING
		do
			from
			until
				file.last_string.is_equal (a_name)
			loop
				file.readline
				file.readword
			end

			file.readword
			Result := file.last_string
		end

	close_file()
		do
			file.close
		end

end
