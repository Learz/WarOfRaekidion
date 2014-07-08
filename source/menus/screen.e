note
	description : "[
					War of Raekidion - A screen object
					A {SCREEN} is a generic object used to define a separate objects
					disposition shown on the window.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

deferred class
	SCREEN

inherit
	MEMORY
	AUDIO_FACTORY_SHARED

feature -- Access

	key_binding: KEYS
		-- Current key binding

	update
		-- Update content of the screen
		do
			from
				buttons.start
			until
				buttons.exhausted
			loop
				buttons.item.update
				buttons.forth
			end

			version.update
		end

feature -- Status

	must_quit: BOOLEAN
		-- True if the screen must quit

	must_close: BOOLEAN
		-- True if the screen must close

	must_end: BOOLEAN
		-- True if the game must end

	is_return_key_pressed: BOOLEAN
		-- True if the return key is pressed

	mouse_button_down: BOOLEAN
		-- True if a mouse button is down

	debug_on: BOOLEAN
		-- True if debug functionalities are activated

feature {NONE} -- Implementation

	window: WINDOW
		-- Window object to use

	buttons: LINKED_LIST [BUTTON]
		-- List of buttons

	button_index: INTEGER
		-- Current active button from `buttons'

	selection: detachable BUTTON
		-- Selected button

	version: TEXT
		-- Game version

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		-- Manage keyboard keys using `a_key' and `a_state'
		do
			if a_state then
				if a_key = key_binding.move_up_key or a_key = key_binding.move_left_key then
					if buttons.count > 1 then
						buttons.at (button_index).reset_image

						if button_index <= 1 then
							button_index := buttons.count
						else
							button_index := button_index - 1
						end

						buttons.at (button_index).set_image (buttons.at (button_index).default_image + "_pressed")
					end
				elseif a_key = key_binding.move_down_key or a_key = key_binding.move_right_key then
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
					play_sound ("select", -1)
				elseif a_key = key_binding.screenshot_key then
					window.take_screenshot
					play_sound ("powerup", -1)
				end
			end
		end

	manage_mouse (a_x, a_y: INTEGER)
		-- Manage button appearance using the mouse position `a_x' and `a_y'
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
		-- Manage mouse clicks using `a_button', `a_x', `a_y' and `a_state'
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
						play_sound ("select", -1)
					end
				end

				mouse_button_down := false
			else
				mouse_button_down := false
			end
		end

	click_button (a_button: INTEGER)
		-- Click actions from `a_button'
		do
		end

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
