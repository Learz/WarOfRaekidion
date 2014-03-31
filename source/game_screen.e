note
	description: "Summary description for {GAME_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_SCREEN

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS)
		local
			l_ticks, l_lasttick, l_deltatime: INTEGER
			l_player: PLAYER_SHIP
			l_enemy: ENEMY_SHIP
			l_background: BACKGROUND
			l_sidebar: SPRITE
			l_event: EVENT_HANDLER
		do
			must_quit := false
			l_event := create {EVENT_HANDLER}.make
			key_binding := a_key_binding
			window := a_window
			l_background := create {BACKGROUND}.make ("background", window, 0, 0, 1)
		    l_player := create {PLAYER_SHIP}.make (window, 112, 300, key_binding)
		    l_enemy := create {ENEMY_SHIP}.make ("enemy_yellow", window, 112, 100, 100)
		    l_sidebar := create {SPRITE}.make ("sidebar", window, window.width - 75, 0)
		    is_return_key_pressed := false
			l_event.on_key_pressed.extend (agent l_player.manage_key)
			l_event.on_key_pressed.extend (agent manage_key)
			l_player.on_collision.extend (agent l_enemy.manage_collision)
			l_enemy.on_collision.extend (agent l_player.manage_collision)

			from
			until
				must_quit
			loop
				if l_event.is_quit_event then
					must_quit := true
				end

				l_ticks := {SDL_WRAPPER}.sdl_getticks.to_integer_32
				l_deltatime := l_ticks - l_lasttick
				l_lasttick := l_ticks
				l_event.manage_event
				window.clear
				l_background.update
			    l_player.update
			    l_enemy.update
			    l_sidebar.update
			    window.render
			   	{SDL_WRAPPER}.sdl_delay (4)
			end
		end

feature -- Status

	must_quit: BOOLEAN

feature {NONE} -- Implementation

	window: WINDOW
	key_binding: KEYS
	is_return_key_pressed: BOOLEAN

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		local
			l_pause_menu: OVERLAY_SCREEN
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "PAUSE")
					must_quit := l_pause_menu.must_quit
					is_return_key_pressed := l_pause_menu.is_return_key_pressed
				end
			else
				if a_key = key_binding.return_key then
					is_return_key_pressed := false
				end
			end
		end

end
