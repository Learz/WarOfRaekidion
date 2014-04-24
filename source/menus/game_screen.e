note
	description: "Summary description for {GAME_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_SCREEN

inherit
	SCREEN
		redefine
			manage_key
		end
	AUDIO_FACTORY_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_server: BOOLEAN; a_network: detachable NETWORK)
		local
			l_ticks, l_deltatime: INTEGER
			l_background: BACKGROUND
			l_sidebar: SPRITE
			l_event: EVENT_HANDLER
			l_network: detachable NETWORK
			l_pause_menu: SCREEN
			l_memory: MEMORY
		do
			window := a_window
			key_binding := a_key_binding
			must_quit := false
		    is_return_key_pressed := false
		    create l_memory
		    create buttons.make
			create enemy_list.make
			create projectile_list.make
			l_network := a_network
			l_memory.collection_on
			l_event := create {EVENT_HANDLER}.make
			l_background := create {BACKGROUND}.make ("background", window, 0, 0, 1)
		    l_sidebar := create {SPRITE}.make ("sidebar", window, window.width - 75, 0)
		    player := create {PLAYER_SHIP}.make (window, 112, 300, key_binding, not a_is_server, l_network)
		    player.on_shoot.extend (agent spawn_projectile)
		    spawner := create {SPAWNER}.make (window, key_binding, a_is_server, l_network)
		    spawner.on_spawn.extend (agent spawn_enemy)
			stop_music
			play_music ("zombie", -1)

		    if attached l_network as la_network then
		    	if a_is_server then
					l_event.on_key_pressed.extend (agent player.manage_key)
				else
					l_event.on_key_pressed.extend (agent spawner.manage_key)
		    	end
		    else
				l_event.on_key_pressed.extend (agent player.manage_key)
				l_event.on_key_pressed.extend (agent spawner.manage_key)
		    end

			l_event.on_key_pressed.extend (agent manage_key)

			from
			until
				must_quit or must_close or must_end
			loop
				l_ticks := {SDL}.sdl_getticks.to_integer_32
				l_event.manage_event

				if l_event.is_quit_event then
					must_quit := true
				end

				window.clear
				l_background.update
				player.update
				spawner.update

				from
					projectile_list.start
				until
					projectile_list.exhausted
				loop
				    if attached projectile_list.item as la_projectile then
				    	if la_projectile.is_destroyed then
				    		projectile_list.remove
				    	else
				    		if not la_projectile.owner then
								if player.has_collided (la_projectile) then
									player.set_health (player.health - la_projectile.projectile_properties.damage)
									la_projectile.destroy
								end
							else
								from
									enemy_list.start
								until
									enemy_list.exhausted
								loop
					   				if attached enemy_list.item as la_enemy then
										if la_enemy.has_collided (la_projectile) then
											la_enemy.set_health (la_enemy.health - la_projectile.projectile_properties.damage)
											la_projectile.destroy
										end
									end

								    if not enemy_list.exhausted then
										enemy_list.forth
								    end
								end
				    		end

				    		la_projectile.update

						    if not projectile_list.exhausted then
								projectile_list.forth
						    end
				    	end
				    end
				end

				if attached l_network as la_network then
					if a_is_server then
						from
							spawner.spawn_list.start
						until
							spawner.spawn_list.exhausted
						loop
							if attached la_network.node as la_node then
								la_node.send_new_enemy_ship (spawner.spawn_list.item.name, spawner.spawn_list.item.x, spawner.spawn_list.item.y, spawner.spawn_list.item.dest_x, spawner.spawn_list.item.dest_y)
							end
						end
					else
						if player.has_moved then
							if attached la_network.node as la_node then
								la_node.send_player_position (player.x.floor, player.y.floor)
							end
						end
					end
				end

				from
					enemy_list.start
				until
					enemy_list.exhausted
				loop
				    if attached enemy_list.item as la_enemy then
				    	if la_enemy.is_destroyed then
				    		enemy_list.remove
				    	else
				    		la_enemy.update (player.x, player.y)

						    if not enemy_list.exhausted then
								enemy_list.forth
						    end
				    	end
				    end
				end

			    l_sidebar.update
			    window.render
				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end

				if player.is_destroyed then
					l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "GAME OVER", true)
					must_quit := l_pause_menu.must_quit
					must_end := l_pause_menu.must_end
					is_return_key_pressed := l_pause_menu.is_return_key_pressed
				end

				if is_paused then
					l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "PAUSE", false)
					is_paused := false
					must_quit := l_pause_menu.must_quit
					must_end := l_pause_menu.must_end
					is_return_key_pressed := l_pause_menu.is_return_key_pressed
				end
			end

--			if attached l_network as la_network then
--				la_network.quit
--			end
		end

feature -- Status

	is_paused: BOOLEAN

feature {NONE} -- Implementation

	player: PLAYER_SHIP
	spawner: SPAWNER
	enemy_list: LINKED_LIST [detachable ENEMY_SHIP]
	projectile_list: LINKED_LIST [detachable PROJECTILE]

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					is_paused := true
				end
			else
				if a_key = key_binding.return_key and is_return_key_pressed then
					is_return_key_pressed := false
				end
			end
		end

	spawn_enemy (a_enemy: ENEMY_SHIP)
		do
			enemy_list.extend (a_enemy)

--			if attached l_network as la_network then
--				if not is_server then
--					la_network.send_data (2, enemy_list.index, a_enemy.id, a_enemy.x, a_enemy.y)
--				end
--			end

		    a_enemy.on_shoot.extend (agent spawn_projectile)
		end

	spawn_projectile (a_projectile: PROJECTILE)
		do
			projectile_list.extend (a_projectile)

--			if attached l_network as la_network then
--				if a_projectile.owner and is_server then
--					la_network.send_data (3, projectile_list.index, a_projectile.id, a_projectile.x, a_projectile.y)
--				end
--			end
		end

end
