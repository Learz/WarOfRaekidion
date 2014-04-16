note
	description: "Summary description for {GAME_SCREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME_SCREEN

inherit
	SCREEN

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_player: BOOLEAN; a_network: detachable NETWORK)
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
		    player := create {PLAYER_SHIP}.make (window, 112, 300, key_binding, a_is_player)
		    player.on_shoot.extend (agent spawn_projectile)
		    spawner := create {SPAWNER}.make (window, key_binding, not a_is_player)
		    spawner.on_spawn.extend (agent spawn_enemy)

		    if attached l_network as la_network then
		    	la_network.set_player_and_spawner (player, spawner)

		    	if a_is_player then
					l_event.on_key_pressed.extend (agent player.manage_key)
				else
					l_event.on_key_pressed.extend (agent spawner.manage_key)
		    	end
		    else
				l_event.on_key_pressed.extend (agent player.manage_key)
		    end

			l_event.on_key_pressed.extend (agent manage_key)

			from
			until
				must_quit or must_close or must_end
			loop
				l_ticks := {SDL}.sdl_getticks.to_integer_32
				l_event.manage_event

				if is_paused then
					l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "PAUSE")
					is_paused := false
					must_quit := l_pause_menu.must_quit
					must_end := l_pause_menu.must_end
					is_return_key_pressed := l_pause_menu.is_return_key_pressed
				end

				if l_event.is_quit_event then
					must_quit := true
				end

				window.clear
				l_background.update

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
					if a_is_player then
						player.update
						if player.has_moved then
							la_network.node.send_player_position (player.x.floor, player.y.floor)
						end

						if attached la_network.spawner as la_spawner then
							la_spawner.update
							spawner := la_spawner
						end
					else
						spawner.update
						from
							spawner.spawn_list.start
						until
							spawner.spawn_list.exhausted
						loop
							la_network.node.send_new_enemy_ship (spawner.spawn_list.item.name, spawner.spawn_list.item.x, spawner.spawn_list.item.y)
						end

						if attached la_network.player_ship as la_player_ship then
							la_player_ship.update
							player := la_player_ship
						end
					end
				else
					player.update
					spawner.update
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
				    		la_enemy.update

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
			end

			if attached l_network as la_network then
				la_network.quit
			end
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
		    a_enemy.on_shoot.extend (agent spawn_projectile)
		end

	spawn_projectile (a_projectile: PROJECTILE)
		do
			projectile_list.extend (a_projectile)
		end

end
