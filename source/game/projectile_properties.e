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

	make (a_name, a_filename, a_sound: STRING; a_damage: INTEGER; a_speed: DOUBLE)
		-- Initialization for `Current'.
		do
			name := a_name
			filename := a_filename
			sound := a_sound
			damage := a_damage
			speed := a_speed
		end

feature -- Access

	name: STRING
	filename: STRING
	sound: STRING
	damage: INTEGER
	speed: DOUBLE

end
