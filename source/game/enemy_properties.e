note
	description: "Summary description for {ENEMY_PROPERTIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make (a_name, a_filename, a_description, a_bullet: STRING; a_health: NATURAL_16; a_count: INTEGER; a_firerate, a_spread, a_speed: DOUBLE)
		-- Initialization for `Current'.
		do
			name := a_name
			filename := a_filename
			description := a_description
			bullet := a_bullet
			health := a_health
			count := a_count
			speed := a_speed
			firerate := a_firerate
			spread := a_spread
		end

feature -- Access

	name: STRING
	filename: STRING
	description: STRING
	bullet: STRING
	health: NATURAL_16
	count: INTEGER
	speed: DOUBLE
	firerate: DOUBLE
	spread: DOUBLE

end
