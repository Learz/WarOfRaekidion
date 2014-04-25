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
			l_score, l_health: TEXT
			l_event: EVENT_HANDLER
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
			network := a_network
			is_server := a_is_server
			l_memory.collection_on
			create l_event.make (window)
			create l_background.make ("background", window, 0, 0, 1)
		    create l_sidebar.make ("sidebar", window, window.width - 75, 0)
		    create player.make (window, 112, 300, key_binding, a_is_server)
		    player.on_shoot.extend (agent spawn_projectile)
		    create spawner.make (window, key_binding, not a_is_server)
		    spawner.on_spawn.extend (agent spawn_enemy)
		    create l_score.make ("0", 16, window, 237, 3, [255, 255, 255], true)

		    if is_server then
		    	create l_health.make (player.health.out, 16, window, 237, 21, [255, 255, 255], true)
		    else
		    	create l_health.make (spawner.money.out, 16, window, 237, 21, [255, 255, 255], true)
		    end

			stop_music
			play_music ("zombie", -1)

		    if attached network as la_network then
		    	if is_server then
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
									if not is_server and not player.is_destroyed then
										score := score + (la_projectile.projectile_properties.damage * 10)
									else
										if attached network as la_network then
											if attached la_network.node as la_node then
												la_node.send_collision (0, projectile_list.index)
											end
										end
									end

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
											if is_server then
												score := score + (la_projectile.projectile_properties.damage * 10)

												if attached network as la_network then
													if attached la_network.node as la_node then
														la_node.send_collision (enemy_list.index, projectile_list.index)
													end
												end
											end

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

				from
					enemy_list.start
				until
					enemy_list.exhausted
				loop
				    if attached enemy_list.item as la_enemy then
				    	if la_enemy.is_destroyed then
							if is_server then
								score := score + (la_enemy.enemy_properties.health * 10)
							end

				    		enemy_list.remove
				    	else
				    		la_enemy.update (player.x, player.y)

						    if not enemy_list.exhausted then
								enemy_list.forth
						    end
				    	end
				    end
				end

				if attached network as la_network then
					if attached la_network.node as la_node then
						if is_server then
							if player.has_moved then
								la_node.send_player_position (player.x.floor, player.y.floor)
							end
						else
							player.set_x (la_node.new_player_position.x)
							player.set_y (la_node.new_player_position.y)
						end
					end
				end

				if player.is_destroyed then
					if not is_server then
						score := score + 10000
					end
				end

			    l_sidebar.update
			    l_score.set_text (score.out, 16)
				l_score.update

				if is_server then
					l_health.set_text (player.health.out, 16)
				else
					l_health.set_text (spawner.money.out, 16)
				end

				l_health.update
			    window.render

				if player.is_destroyed then
					l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "GAME OVER", "Score: "+score.out, true)
					must_quit := l_pause_menu.must_quit
					must_end := l_pause_menu.must_end
					is_return_key_pressed := l_pause_menu.is_return_key_pressed
				end

				if is_paused then
					l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "PAUSE", "", false)
					is_paused := false
					must_quit := l_pause_menu.must_quit
					must_end := l_pause_menu.must_end
					is_return_key_pressed := l_pause_menu.is_return_key_pressed
				end

				l_deltatime := {SDL}.sdl_getticks.to_integer_32 - l_ticks

				if l_deltatime < (1000 / 60).floor then
			   		{SDL}.sdl_delay ((1000 / 60).floor - l_deltatime)
				end
			end

			if attached network as la_network then
				la_network.quit
			end
		end

feature -- Status

	is_paused, is_server: BOOLEAN

feature {NONE} -- Implementation

	score: INTEGER
	player: PLAYER_SHIP
	network: detachable NETWORK
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

	spawn_enemy (a_name: STRING; a_x, a_y, a_dest_x, a_dest_y: INTEGER)
		local
			l_enemy: ENEMY_SHIP
		do
			create l_enemy.make (a_name, window, a_x, a_y, a_dest_x, a_dest_y)
			enemy_list.extend (l_enemy)

			if not is_server then
				if attached network as la_network then
					if not is_server and attached la_network.node as la_node then
						la_node.send_new_enemy_ship (a_name, a_x, a_y, a_dest_x, a_dest_y)
					end
				end
			end

		    l_enemy.on_shoot.extend (agent spawn_projectile)
		end

	spawn_projectile (a_name: STRING; a_x, a_y: INTEGER; a_angle: DOUBLE; a_owner: BOOLEAN)
		do
			projectile_list.extend (create {PROJECTILE}.make (a_name, window, a_x, a_y, a_angle, a_owner))

			if is_server and a_owner then
				if attached network as la_network then
					if attached la_network.node as la_node then
						la_node.send_projectile (a_name, a_x, a_y, a_angle)
					end
				end
			end
		end

end
