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
			l_entity: ENTITY
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
			create entities_list.make
			l_event := create {EVENT_HANDLER}.make
			l_background := create {BACKGROUND}.make ("background", window, 0, 0, 1)
		    l_sidebar := create {SPRITE}.make ("sidebar", window, window.width - 75, 0)
		    player := create {PLAYER_SHIP}.make (window, 112, 300, key_binding)
			l_event.on_key_pressed.extend (agent player.manage_key)
			l_event.on_key_pressed.extend (agent manage_key)

		    entities_list.extend (player)
		    player.on_creation.extend (agent manage_creation)
		    -- manage_creation (create {ENEMY_SHIP}.make ("enemy_red", window, 152, 100, 20))

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

				from
					entities_list.start
				until
					entities_list.exhausted
				loop
				    if attached entities_list.item as la_entity then
				    	if la_entity.is_destroyed then
				    		entities_list.remove
				    		l_memory.free (la_entity)
				    	else
				    		la_entity.update
						    if not entities_list.exhausted then
								entities_list.forth
						    end
				    	end
				    end
				end

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
	entities_list: LINKED_LIST [detachable ENTITY]
	player: PLAYER_SHIP

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
		    entities_list.extend (a_entity)
		    if a_entity.type.has_substring ("projectile") then
		    	--a_entity.on_collision.extend (agent player.manage_collision)
		    elseif a_entity.type.has_substring ("ship") then
		    	a_entity.on_creation.extend (agent manage_creation)
		    end
		end

end
