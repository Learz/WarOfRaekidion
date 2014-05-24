note
	description	: "[
					War of Raekidion - A projectile type definition
					A {PROJECTILE_PROPERTIES} contains every properties a 
					projectile needs to be instanciated.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	PROJECTILE_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make (a_name, a_filename, a_sound: STRING; a_damage, a_speed: DOUBLE; a_homing: BOOLEAN; a_lifetime: INTEGER; a_explodes: BOOLEAN)
		-- Initialize `Current' from `a_name', `a_filename', `a_sound', `a_damage', `a_speed', `a_homing', `a_lifetime', `a_explodes'
		do
			name := a_name
			filename := a_filename
			sound := a_sound
			damage := a_damage
			speed := a_speed
			homing := a_homing
			lifetime := a_lifetime
			explodes := a_explodes
		end

feature -- Access

	name: STRING
		-- The projectile's name

	filename: STRING
		-- The image file name

	sound: STRING
		-- The sound produced upon firing the projectile

	damage: DOUBLE
		-- The damage dealt by the projectile

	speed: DOUBLE
		-- The speed of the bullet

	homing: BOOLEAN
		-- True if the bullet should change direction to always go towards the player

	lifetime: INTEGER
		-- The time the projectile should live

	explodes: BOOLEAN
		-- True if the projectile should explode more violently on impact

note
	copyright: "[
				War of Raekidion
				Copyright (C) 2014 François Allard <binarmorker@gmail.com>
             		   		   and Marc-Antoine Renaud <legars123456@gmail.com>
               ]"
	license:   "GNU General Public License, <http://www.gnu.org/licenses/>"

end
