note
	description: "Summary description for {SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCREEN

inherit
	MEMORY

feature -- Access

	key_binding: KEYS

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

			full_collect
		end

feature -- Status

	must_quit, must_close, must_end, is_return_key_pressed, mouse_button_down: BOOLEAN

feature {NONE} -- Implementation
	window: WINDOW
	buttons: LINKED_LIST [BUTTON]
	button_index: INTEGER
	selection: detachable BUTTON

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		do
			if a_state then
				if a_key = key_binding.move_up_key then
					if buttons.count > 1 then
						buttons.at (button_index).reset_image

						if button_index <= 1 then
							button_index := buttons.count
						else
							button_index := button_index - 1
						end

						buttons.at (button_index).set_image (buttons.at (button_index).default_image + "_pressed")
					end
				elseif a_key = key_binding.move_down_key then
					if buttons.count > 1 then
						buttons.at (button_index).reset_image

						if button_index >= buttons.count then
							button_index := 1
						else
							button_index := button_index + 1
						end

						buttons.at (button_index).set_image (buttons.at (button_index).default_image + "_pressed")
					end
				elseif a_key = key_binding.accept_key then
					click_button (button_index)
				end
			end
		end

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
