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

	root: detachable XML_ELEMENT

	parse_from_filename (a_filename: STRING)
		do
			parser.parse_from_path (create {PATH}.make_from_string (a_filename))
			document := callbacks.document
			root := document.root_element
		end

	process_node (a_name: STRING): detachable STRING_32
		do
			if attached root as la_root and then
			   attached la_root.element_by_name (a_name) as la_node then
				Result := la_node.text
			end
		end

feature {NONE} -- Implementation

	parser: XML_STANDARD_PARSER

	callbacks: XML_CALLBACKS_DOCUMENT

end
