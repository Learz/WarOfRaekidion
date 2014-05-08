note
	description: "Summary description for {ENEMY_PROPERTIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECTILE_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make (a_name, a_filename, a_sound: STRING; a_damage, a_speed: DOUBLE; a_homing: BOOLEAN; a_lifetime: INTEGER; a_explodes: BOOLEAN)
		-- Initialization for `Current'.
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
	filename: STRING
	sound: STRING
	damage: DOUBLE
	speed: DOUBLE
	homing: BOOLEAN
	lifetime: INTEGER
	explodes: BOOLEAN

end
