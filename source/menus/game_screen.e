note
	description : "[
					War of Raekidion - The game screen
					The {GAME_SCREEN} is the main screen of the game, containing all player
					and ennemy actions as well as the use of the network capabilities.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	GAME_SCREEN

inherit
	SCREEN
		redefine
			manage_key
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: WINDOW; a_key_binding: KEYS; a_is_server, a_debug: BOOLEAN; a_difficulty: INTEGER; a_network: detachable NETWORK)
		-- Initialize `Current' from `a_window', `a_key_binding', `a_is_server', `a_debug', `a_difficulty' and `a_network'
		local
			l_ticks, l_deltatime: INTEGER
			l_background: BACKGROUND
			l_sidebar: SPRITE
			l_score: TEXT
			l_opponent_score: detachable TEXT
			l_health: TEXT
			l_energy: TEXT
			l_health_bar: STATUS_BAR
			l_energy_bar: STATUS_BAR
			l_event: EVENT_HANDLER
			l_pause_menu: SCREEN
			l_lives: INTEGER
		do
			collection_on
			debug_on := a_debug
			window := a_window
			key_binding := a_key_binding
			must_quit := false
		    is_return_key_pressed := false
		    create difficulty_text.make_empty
		    create buttons.make
			create enemy_list.make
			create projectile_list.make
			create powerup_list.make
			create explosion_list.make
			network := a_network
			is_server := a_is_server
			difficulty := a_difficulty
			create l_event.make (window)
			create l_background.make ("background", window, 0, 0, 1)
		    create l_sidebar.make ("sidebar", window, window.width - 75, 0)
		    create player.make (window, 112, 300, key_binding, a_is_server)
		    player.on_shoot.extend (agent spawn_projectile)
		    create spawner.make (window, key_binding, not a_is_server)
		    spawner.on_spawn.extend (agent spawn_enemy)
		    create l_score.make ("0", 16, window, 237, 3, [255, 255, 255], true)
			create version.make (window.version, 10, window, 294, 394, [192, 192, 192], false)
			version.set_x (version.x - version.width)
			version.set_y (version.y - version.height)

--		    if is_server then
		    	create l_health.make_centered ("HEALTH", 10, window, 237, 22, 59, 7, [255, 255, 255], false)
		    	create l_energy.make_centered ("ENERGY", 10, window, 237, 29, 59, 7, [255, 255, 255], false)
		    	create l_health_bar.make (window, 237, 22, 59, 7, [192, 32, 32, 255], false)
		    	create l_energy_bar.make (window, 237, 29, 59, 7, [96, 96, 192, 255], false)
				l_health_bar.set_value (player.health.floor)
				l_energy_bar.set_value (player.energy.floor)
--		    else
--		    	create l_label.make ("C$: ", 16, window, 237, 21, [255, 255, 255], true)
--		    	create l_health.make (spawner.money.out, 16, window, 257, 21, [255, 255, 255], true)
--		    end

			stop_music
			play_music ("chicago", -1)
			l_event.on_key_pressed.extend (agent manage_key)

			if attached network as la_network then
				create l_opponent_score.make ("0", 16, window, 237, 39, [192, 192, 192], true)
				create network_player.make ("disabled_player", window, 1000, 1000, 1, 1)

--		    	if is_server then
					l_event.on_key_pressed.extend (agent player.manage_key)
--				else
					spawner.set_ai (true)
--		    	end
		    else
				l_event.on_key_pressed.extend (agent player.manage_key)
				spawner.set_ai (true)
			end

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
--				network_update
				powerup_update
				collisions_update
				projectiles_update
				explosions_update

--				if attached network as la_network then
--					if attached la_network.node as la_node then
--						if is_server then
--							if player.has_moved then
--								la_node.send_player_position (player.x.floor, player.y.floor)
--							end
--						else
--							player.set_x (la_node.new_player_position.x)
--							player.set_y (la_node.new_player_position.y)
--						end
--					end
--				end

--				if player.is_destroyed then
--					if not is_server then
--						score := score + 10000
--						score_changed := true
--					end
--				end

			    l_sidebar.update

			    if score_changed then
			    	if attached network as la_network and then attached la_network.node as la_node then
						la_node.send_score (score)
					end

			    	l_score.set_text (score.out, 16)
			    	score_changed := false
			    end

				l_score.update
			    --l_label.update

			    if attached l_opponent_score as la_score then
			    	la_score.update
			    end

			    version.update

				if health_changed then
--					if is_server then
						--l_health.set_text (player.health.floor.out, 16)
						l_health_bar.set_value (player.health.floor)
--					else
--						l_health.set_text (spawner.money.out, 16)
--					end

					health_changed := false
				end

				l_health_bar.update
				l_energy_bar.set_value (player.energy.floor)
				l_energy_bar.update
				l_health.update
				l_energy.update
			    window.render

			    if attached network as la_network and then
				attached la_network.node as la_node and
				attached network_player as la_network_player and
				attached l_opponent_score as la_score then
					if la_network.connection_error then
						la_network.quit
						network := void
						la_score.destroy
						l_opponent_score := void
						l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "YOU WON!", "Your score: "+score.out, "Your opponent's score: "+la_node.new_score.out, true, debug_on, difficulty, -1)
						must_quit := l_pause_menu.must_quit
						must_end := l_pause_menu.must_end
						is_return_key_pressed := l_pause_menu.is_return_key_pressed
					else
						la_node.send_player_position (player.x.floor, player.y.floor)
						la_network_player.set_x (la_node.new_player_position.x)
						la_network_player.set_y (la_node.new_player_position.y)
						la_score.set_text (la_node.new_score.out, 16)
						la_network_player.update
					end
				end

				if l_lives > player.lives then
					explosion_list.extend (create {EXPLOSION}.make ("explosion_big", 13, 50, window, player.x, player.y, false))
					player.disable (500)
				end

				l_lives := player.lives

				if player.is_destroyed then
					if attached network as la_network and then
					attached la_network.node as la_node and
					attached network_player as la_network_player and
					attached l_opponent_score as la_score then
						la_network.quit
						network := void
						la_score.destroy
						l_opponent_score := void
						l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "YOU LOST!", "Your score: "+score.out, "Your opponent's score: "+la_node.new_score.out, true, debug_on, difficulty, score)
					else
						if difficulty = 16 then
							difficulty_text := "HELL"
						elseif difficulty = 8 then
							difficulty_text := "NUTS"
						elseif difficulty = 4 then
							difficulty_text := "HARD"
						elseif difficulty = 2 then
							difficulty_text := "EASY"
						else
							difficulty_text := "CAKE"
						end

						l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "GAME OVER", "Score: "+score.out, difficulty_text, true, debug_on, difficulty, score)
					end

					must_quit := l_pause_menu.must_quit
					must_end := l_pause_menu.must_end
					is_return_key_pressed := l_pause_menu.is_return_key_pressed
				end

				if is_paused then
					l_pause_menu := create {OVERLAY_SCREEN}.make (window, key_binding, is_return_key_pressed, "PAUSE", "", "", false, debug_on, difficulty, -1)
					is_paused := false
					key_binding := l_pause_menu.key_binding
					player.set_key_binding (key_binding)
					spawner.set_key_binding (key_binding)
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

	is_paused: BOOLEAN
		-- True if the game is paused

	is_server: BOOLEAN
		-- True if the player is hosting

	score_changed: BOOLEAN
		-- True if the player score changes

	health_changed: BOOLEAN
		-- True if the player health changes


feature {NONE} -- Implementation

	difficulty: INTEGER
		-- Difficulty of the game

	difficulty_text: STRING
		-- Name of the current difficulty

	score: INTEGER
		-- Score of `player'

	player: PLAYER_SHIP
		-- Ship object for the player

	network_player: detachable ENTITY
		-- Entity to represent the ship of the network opponent

	network: detachable NETWORK
		-- Network object for online communications

	spawner: SPAWNER
		-- Ennemy spawner

	enemy_list: LINKED_LIST [detachable ENEMY_SHIP]
		-- List of ennemies

	projectile_list: LINKED_LIST [detachable PROJECTILE]
		-- List of projectiles

	powerup_list: LINKED_LIST [detachable POWERUP]
		-- List of powerups

	explosion_list: LINKED_LIST [detachable EXPLOSION]
		-- List of explosions

	network_update
		-- (OBSOLETE) Update the network transferred data
		do
			if attached network as la_network then
				if attached la_network.node as la_node then
					if is_server then
						from
							la_node.new_enemies.start
						until
							la_node.new_enemies.exhausted
						loop
							spawn_enemy (la_node.new_enemies.item.name, la_node.new_enemies.item.x,
										 la_node.new_enemies.item.y, la_node.new_enemies.item.dest_x, la_node.new_enemies.item.dest_y)
							la_node.new_enemies.remove

							if not la_node.new_enemies.exhausted then
								la_node.new_enemies.forth
							end
						end
					else
						from
							la_node.new_projectiles.start
						until
							la_node.new_projectiles.exhausted
						loop
							spawn_projectile (la_node.new_projectiles.item.name, la_node.new_projectiles.item.x,
											  la_node.new_projectiles.item.y, la_node.new_projectiles.item.angle, player)
							la_node.new_projectiles.remove

							if not la_node.new_projectiles.exhausted then
								la_node.new_projectiles.forth
							end
						end
					end
				end
			end
		end

	collisions_update
		-- Update the collision detection and react in accordance
		do
			from
				projectile_list.start
			until
				projectile_list.exhausted
			loop
			    if attached projectile_list.item as la_projectile then
			    	if la_projectile.is_destroyed then
			    		if la_projectile.will_explode then
			    			if la_projectile.projectile_properties.explodes then
								explosion_list.extend (create {EXPLOSION}.make ("explosion_big", 13, 50, window, la_projectile.x, la_projectile.y, false))
								play_sound ("explosion", -1)
							else
								explosion_list.extend (create {EXPLOSION}.make ("explosion", 14, 20, window, la_projectile.x, la_projectile.y, false))
								play_sound ("hit", -1)
				    		end
			    		end

			    		free (la_projectile)
			    		projectile_list.remove
			    	else
			    		if la_projectile.owner /= player then
							if player.has_collided (la_projectile) and not player.is_disabled then
								if not is_server and not player.is_destroyed then
									score := score + (la_projectile.projectile_properties.damage * 10).floor
									score_changed := true
--								else
--									if attached network as la_network then
--										if attached la_network.node as la_node then
--											la_node.send_collision (0, projectile_list.index)
--										end
--									end
								end

								player.set_health (player.health - la_projectile.projectile_properties.damage)

								if is_server then
									health_changed := true
								end

								if spawner.is_ai then
									spawner.set_money (spawner.money + (la_projectile.projectile_properties.damage * difficulty * 0.5).floor)
								else
									spawner.set_money (spawner.money + (la_projectile.projectile_properties.damage).floor)

									if not is_server then
										health_changed := true
									end
								end

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
											score := score + (la_projectile.projectile_properties.damage * 10 * (difficulty / 2.5)).floor
											score_changed := true

--											if attached network as la_network then
--												if attached la_network.node as la_node then
--													la_node.send_collision (enemy_list.index, projectile_list.index)
--												end
--											end
										end

										la_enemy.set_health (la_enemy.health - la_projectile.projectile_properties.damage)

										if spawner.is_ai then
											spawner.set_money (spawner.money + (la_projectile.projectile_properties.damage * difficulty * 0.5).floor)
										else
											spawner.set_money (spawner.money + (la_projectile.projectile_properties.damage).floor)

											if not is_server then
												health_changed := true
											end
										end

										la_projectile.destroy
									end
								end

							    if not enemy_list.exhausted then
									enemy_list.forth
							    end
							end
			    		end

			    		la_projectile.update (player.x, player.y)

					    if not projectile_list.exhausted then
							projectile_list.forth
					    end
			    	end
			    end
			end
		end

	powerup_update
		-- Update the powerup list
		do
			from
				powerup_list.start
			until
				powerup_list.exhausted
			loop
			    if attached powerup_list.item as la_powerup then
			    	if la_powerup.is_destroyed then
			    		free (la_powerup)
			    		powerup_list.remove
			    	else
						if player.has_collided (la_powerup) then
							if spawner.is_ai then
								if player.health >= player.max_health then
									if is_server then
										score := score + difficulty
										score_changed := true
									end
								else
									player.set_health (player.health + (1 / difficulty))
									player.set_energy (player.energy + (4 / difficulty))

									if is_server then
										health_changed := true
									end
								end
							end

							play_sound ("powerup", -1)
							la_powerup.destroy
						end

			    		la_powerup.update (player.x, player.y)

					    if not powerup_list.exhausted then
							powerup_list.forth
					    end
			    	end
				end
			end
		end

	projectiles_update
		-- Update the projectile list
		do
			from
				enemy_list.start
			until
				enemy_list.exhausted
			loop
			    if attached enemy_list.item as la_enemy then
			    	if la_enemy.is_destroyed then
						if is_server then
							score := score + (la_enemy.enemy_properties.health * 10 * (difficulty / 2.5)).floor
							score_changed := true
						end

						from
							projectile_list.start
						until
							projectile_list.exhausted
						loop
							if attached projectile_list.item as la_projectile and then la_projectile.owner = la_enemy then
								powerup_list.extend (create {POWERUP}.make ("powerup", window, la_projectile.x, la_projectile.y, 1))
								free (la_projectile)
								projectile_list.remove
							else
								projectile_list.forth
							end
						end

						explosion_list.extend (create {EXPLOSION}.make ("explosion_big", 13, 50, window, la_enemy.x, la_enemy.y, false))
						play_sound ("explosion", -1)
						free (la_enemy)
			    		enemy_list.remove
			    	else
			    		la_enemy.update (player.x, player.y)

					    if not enemy_list.exhausted then
							enemy_list.forth
				   		end
			    	end
			    end
			end
		end

	explosions_update
		-- Update the explosion list
		do
			from
				explosion_list.start
			until
				explosion_list.exhausted
			loop
			    if attached explosion_list.item as la_explosion then
			    	if la_explosion.is_destroyed then
			    		free (la_explosion)
			    		explosion_list.remove
			    	else
			    		la_explosion.update

					    if not explosion_list.exhausted then
							explosion_list.forth
					    end
			    	end
			    end
			end
		end

	manage_key (a_key: INTEGER_32; a_state: BOOLEAN)
		-- Manage the pause action and the screenshot action
		do
			if a_state then
				if a_key = key_binding.return_key and not is_return_key_pressed then
					is_return_key_pressed := true
					is_paused := true
				elseif a_key = key_binding.screenshot_key then
					window.take_screenshot
				end
			else
				if a_key = key_binding.return_key and is_return_key_pressed then
					is_return_key_pressed := false
				end
			end
		end

	spawn_enemy (a_name: STRING; a_x, a_y, a_dest_x, a_dest_y: INTEGER)
		-- Add ennemy `a_name' originating from `a_x' and `a_y' moving to `a_dest_x' and `a_dest_y'
		local
			l_enemy: ENEMY_SHIP
			l_max_enemies: INTEGER
		do
			if difficulty = 1 then
				l_max_enemies := 6
			elseif difficulty = 2 then
				l_max_enemies := 8
			elseif difficulty = 4 then
				l_max_enemies := 10
			elseif difficulty = 8 then
				l_max_enemies := 12
			elseif difficulty = 16 then
				l_max_enemies := 14
			end

			if enemy_list.count < l_max_enemies then
				create l_enemy.make (a_name, window, a_x, a_y, a_dest_x, a_dest_y)

				if spawner.money >= l_enemy.enemy_properties.price then
					enemy_list.extend (l_enemy)
					spawner.set_money (spawner.money - l_enemy.enemy_properties.price)
				end

--				if not is_server then
--					if attached network as la_network then
--						if attached la_network.node as la_node then
--							la_node.send_new_enemy_ship (a_name, a_x, a_y, a_dest_x, a_dest_y)
--						end
--					end
--				end

			    l_enemy.on_shoot.extend (agent spawn_projectile)
			end
		end

	spawn_projectile (a_name: STRING; a_x, a_y: INTEGER; a_angle: DOUBLE; a_owner: SHIP)
		-- Add projectile `a_name' originating from `a_x' and `a_y' at angle `a_angle' from the owner `a_owner'
		do
			projectile_list.extend (create {PROJECTILE}.make (a_name, window, a_x, a_y, a_angle, a_owner))

--			if is_server and a_owner = player then
--				if attached network as la_network then
--					if attached la_network.node as la_node then
--						la_node.send_projectile (a_name, a_x, a_y, a_angle)
--					end
--				end
--			end
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
