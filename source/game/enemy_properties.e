note
	description	: "[
					War of Raekidion - An enemy type definition
					An {ENEMY_PROPERTIES} contains every properties an 
					enemy needs to be instanciated.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	ENEMY_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make (a_name, a_filename, a_description, a_bullet, a_sound: STRING; a_health: DOUBLE; a_count, a_firerate, a_price: INTEGER; a_spread, a_speed: DOUBLE; a_aiming: BOOLEAN)
		-- Initialize `Current' from `a_name', `a_description', `a_bullet', `a_health', `a_count', `a_firerate', `a_price', `a_spread', `a_speed' and `a_aiming'
		do
			name := a_name
			filename := a_filename
			description := a_description
			bullet := a_bullet
			sound := a_sound
			health := a_health
			count := a_count
			firerate := a_firerate
			price := a_price
			spread := a_spread
			speed := a_speed
			aiming := a_aiming
		end

feature -- Access

	name: STRING
		-- The enemy ship's name

	filename: STRING
		-- The image file name

	description: STRING
		-- The enemy ship's description

	bullet: STRING
		-- The bullet type the enemy shoots

	sound: STRING
		-- The sound produced upon firing projectiles

	health: DOUBLE
		-- The enemy's health

	count: INTEGER
		-- The number of bullets the enemy shoots at once

	firerate: INTEGER
		-- The number of frames to wait for another bullet

	price: INTEGER
		-- The price of the ship for the spawner

	spread: DOUBLE
		-- The spread angle of the bullets

	speed: DOUBLE
		-- The arrival speed of the ship

	aiming: BOOLEAN
		-- True if the bullets should automatically aim for the player

invariant

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
