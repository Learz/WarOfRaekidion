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
			l_background: BACKGROUND
			l_sidebar: SPRITE
			l_event: EVENT_HANDLER
			l_memory: MEMORY
		do
			window := a_window
			key_binding := a_key_binding
			must_quit := false
		    is_return_key_pressed := false
		    create l_memory
			create enemy_list.make
			create projectile_list.make
			l_memory.collection_on
			l_event := create {EVENT_HANDLER}.make
			l_background := create {BACKGROUND}.make ("background", window, 0, 0, 1)
		    l_sidebar := create {SPRITE}.make ("sidebar", window, window.width - 75, 0)
		    player := create {PLAYER_SHIP}.make (window, 112, 300, key_binding)
			l_event.on_key_pressed.extend (agent player.manage_key)
			l_event.on_key_pressed.extend (agent manage_key)
		    player.on_creation.extend (agent manage_creation)
		    manage_creation (create {ENEMY_SHIP}.make ("enemy_red", window, 50, 100, 20))
		    manage_creation (create {ENEMY_SHIP}.make ("enemy_yellow", window, 150, 100, 20))

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

				player.update

				from
					enemy_list.start
				until
					enemy_list.exhausted
				loop
				    if attached enemy_list.item as la_enemy then
				    	if la_enemy.is_destroyed then
				    		enemy_list.remove
				    	else
				    		la_enemy.update
						    if not enemy_list.exhausted then
								enemy_list.forth
						    end
				    	end
				    end
				end

				from
					projectile_list.start
				until
					projectile_list.exhausted
				loop
				    if attached projectile_list.item as la_projectile then
				    	if la_projectile.is_destroyed then
				    		projectile_list.remove
				    	else
				    		la_projectile.update
						    if not projectile_list.exhausted then
								projectile_list.forth
						    end
				    	end
				    end
				end

			    l_sidebar.update
			    window.render
			    l_memory.full_collect
			   	{SDL_WRAPPER}.sdl_delay (4)
			end
		end

feature -- Status

	must_quit: BOOLEAN

feature {NONE} -- Implementation

	window: WINDOW
	key_binding: KEYS
	is_return_key_pressed: BOOLEAN
	player: PLAYER_SHIP
	enemy_list: LINKED_LIST [detachable ENTITY]
	projectile_list: LINKED_LIST [detachable ENTITY]

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

	manage_creation (a_entity: ENTITY)
		do
		    if a_entity.type.has_substring ("projectile") then
		    	projectile_list.extend (a_entity)
		    	if a_entity.type.has_substring ("player") then
		    		from
		    			enemy_list.start
		    		until
		    			enemy_list.exhausted
		    		loop
		    			if attached enemy_list.item as la_enemy then
		    				a_entity.on_collision.extend (agent la_enemy.manage_collision)
		    			end
		    			enemy_list.forth
		    		end
		    	else
		    		a_entity.on_collision.extend (agent player.manage_collision)
		    	end
		    elseif a_entity.type.has_substring ("ship") then
		    	enemy_list.extend (a_entity)
		    	a_entity.on_creation.extend (agent manage_creation)
		    end
		end

end
