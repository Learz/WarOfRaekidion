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
			l_player: detachable PLAYER_SHIP
			l_enemy1, l_enemy2: detachable ENEMY_SHIP
			l_background: BACKGROUND
			l_sidebar: SPRITE
			l_event: EVENT_HANDLER
			l_memory: MEMORY
		do
			must_quit := false
			l_event := create {EVENT_HANDLER}.make
			key_binding := a_key_binding
			window := a_window
			l_background := create {BACKGROUND}.make ("background", window, 0, 0, 1)
		    l_player := create {PLAYER_SHIP}.make (window, 112, 300, key_binding)
		    l_enemy1 := create {ENEMY_SHIP}.make ("enemy_yellow", window, 52, 100, 20)
		    l_enemy2 := create {ENEMY_SHIP}.make ("enemy_red", window, 162, 100, 20)
		    l_sidebar := create {SPRITE}.make ("sidebar", window, window.width - 75, 0)
		    is_return_key_pressed := false
		    create l_memory
			l_event.on_key_pressed.extend (agent l_player.manage_key)
			l_event.on_key_pressed.extend (agent manage_key)
			l_player.on_collision.extend (agent l_enemy1.manage_collision)
			l_player.on_collision.extend (agent l_enemy2.manage_collision)
			l_enemy1.on_collision.extend (agent l_player.manage_collision)
			l_enemy2.on_collision.extend (agent l_player.manage_collision)

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

			    if attached l_player as la_player then
			    	if la_player.is_destroyed then
				    	l_player := void
				    else
			    		la_player.update
				    end
			    end

			    if attached l_enemy1 as la_enemy1 then
			    	if la_enemy1.is_destroyed then
			    		l_enemy1 := void
			    	else
			    		la_enemy1.update
			    	end
			    end

			    if attached l_enemy2 as la_enemy2 then
			    	if la_enemy2.is_destroyed then
			    		l_enemy2 := void
			    	else
			    		la_enemy2.update
			    	end
			    end

			    l_sidebar.update
			    window.render
			   	{SDL_WRAPPER}.sdl_delay (4)
			   	l_memory.full_collect
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
