note
	description: "Summary description for {SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCREEN

feature -- Access

	update
		do
			from
				buttons.start
			until
				buttons.exhausted
			loop
				buttons.item.update
				buttons.forth
			end
		end

feature -- Status

	must_quit, must_close, must_end, is_return_key_pressed, mouse_button_down: BOOLEAN

feature {NONE} -- Implementation

	key_binding: KEYS
	window: WINDOW
	buttons: LINKED_LIST [BUTTON]
	selection: detachable BUTTON

	manage_mouse (a_x, a_y: INTEGER)
		do
			from
				buttons.start
			until
				buttons.exhausted
			loop
				if (a_x >= buttons.item.x and a_x <= buttons.item.x + buttons.item.width)
				and (a_y >= buttons.item.y and a_y <= buttons.item.y + buttons.item.height) then
					buttons.item.set_image (buttons.item.default_image + "_pressed")
				elseif buttons.item.current_image /= buttons.item.default_image then
					buttons.item.reset_image
				end

				buttons.forth
			end
		end

	manage_click (a_button: NATURAL_32; a_x, a_y: INTEGER; a_state: BOOLEAN)
		do
			if a_state then
				from
					buttons.start
				until
					buttons.exhausted
				loop
					if (a_x >= buttons.item.x and a_x <= buttons.item.x + buttons.item.width)
					and (a_y >= buttons.item.y and a_y <= buttons.item.y + buttons.item.height) then
						selection := buttons.item
						mouse_button_down := true
					end

					buttons.forth
				end
			elseif mouse_button_down then
				if attached selection as la_selection then
					if (a_x >= la_selection.x and a_x <= la_selection.x + la_selection.width)
					and (a_y >= la_selection.y and a_y <= la_selection.y + la_selection.height) then
						click_button (buttons.index_of (la_selection, 1))
					end
				end
				
				mouse_button_down := false
			else
				mouse_button_down := false
			end
		end

	click_button (a_button: INTEGER)
		do
		end

end
