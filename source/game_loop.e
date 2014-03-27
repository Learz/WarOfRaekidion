note
	description: "Summary description for {GAME_LOOP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_LOOP

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS)
		local
			l_ticks, l_lasttick, l_deltatime: INTEGER
			l_background: BACKGROUND
			l_player: PLAYER_SHIP
			l_enemy, l_enemy2: ENEMY_SHIP
			l_sidebar: USER_INTERFACE
			l_event: EVENT_HANDLER
		do
			must_quit := false
			l_event := create {EVENT_HANDLER}.make
			key_binding := a_key_binding
			window := a_window
			l_background := create {BACKGROUND}.make ("background", window, 0, 0, 1)
		    l_player := create {PLAYER_SHIP}.make (window, 150, 400, key_binding)
		    l_enemy := create {ENEMY_SHIP}.make ("enemyUFO", window, 50, 150)
		    --l_enemy2 := create {ENEMY_SHIP}.make ("enemyUFO", window, 250, 150)
		    l_sidebar := create {USER_INTERFACE}.make ("sidebar", window, window.width - 100, 0)
		    is_return_key_pressed := false
			l_event.on_key_pressed.extend (agent l_player.manage_key)
			l_event.on_key_pressed.extend (agent manage_key)

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
			    {SDL_WRAPPER}.sdl_delay (4)
				l_event.manage_event
				window.render_clear
				l_background.update
			    l_player.update
			    l_enemy.update
			    --l_enemy2.update
			    l_sidebar.update
			    window.render
			end
		end

feature -- Status

	must_quit: BOOLEAN

feature {NONE} -- Implementation

	window: WINDOW
	key_binding: KEYS
	is_return_key_pressed: BOOLEAN

	manage_key (a_key: INTEGER; a_state: BOOLEAN)
		local
			l_pause_menu: PAUSE_MENU
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					l_pause_menu := create {PAUSE_MENU}.make (window, key_binding, is_return_key_pressed)
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
