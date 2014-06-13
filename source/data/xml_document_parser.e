note
	description: "Summary description for {XML_DOCUMENT_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_DOCUMENT_PARSER

create
	make

feature {NONE} -- Initialization

	make
		do
			create parser.make
			create callbacks.make_null
			create document.make
			parser.set_callbacks (callbacks)
		end

feature -- Access

	document: XML_DOCUMENT

	modify_node (a_name, a_value: STRING)
		local
			l_element: XML_ELEMENT
			l_content: XML_CHARACTER_DATA
		do
			if attached document.root_element as la_root then
				if attached la_root.element_by_name (a_name) as la_node then
					la_node.contents.wipe_out
					create l_content.make (la_node, a_value)
				else
					create l_element.make_last (la_root, a_name, la_root.namespace)
					create l_content.make_last (l_element, a_value)
				end
			end
		end

	parse_from_filename (a_filename: STRING)
		do
			parser.parse_from_path (create {PATH}.make_from_string (a_filename))
			document := callbacks.document
		end

	save_document (a_filename: STRING)
		local
			l_output: XML_INDENT_PRETTY_PRINT_FILTER
			l_file: PLAIN_TEXT_FILE
		do
			create l_output.make_null
			create l_file.make_create_read_write (a_filename)
			l_file.flush
			l_output.set_indent ("%T")
			l_output.set_output_file (l_file)
			document.process_to_events (l_output)
			l_file.close
		end

	process_node (a_name: STRING): detachable XML_ELEMENT
		do
			if attached document.root_element as la_root and then
			   attached la_root.element_by_name (a_name) as la_node then
				Result := la_node
			end
		end

feature {NONE} -- Implementation

	parser: XML_STANDARD_PARSER

	callbacks: XML_CALLBACKS_DOCUMENT

end
