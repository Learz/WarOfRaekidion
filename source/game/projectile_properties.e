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

	make (a_name, a_filename, a_sound: STRING; a_damage: INTEGER; a_speed: DOUBLE; a_homing: BOOLEAN)
		-- Initialization for `Current'.
		do
			name := a_name
			filename := a_filename
			sound := a_sound
			damage := a_damage
			speed := a_speed
			homing := a_homing
		end

feature -- Access

	name: STRING
	filename: STRING
	sound: STRING
	damage: INTEGER
	speed: DOUBLE
	homing: BOOLEAN

end
