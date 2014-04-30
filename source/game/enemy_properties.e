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

	make (a_name, a_filename, a_description, a_bullet: STRING; a_health: DOUBLE; a_count, a_firerate, a_price: INTEGER; a_spread, a_speed: DOUBLE; a_aiming: BOOLEAN)
		-- Initialization for `Current'.
		do
			name := a_name
			filename := a_filename
			description := a_description
			bullet := a_bullet
			health := a_health
			count := a_count
			price := a_price
			firerate := a_firerate
			spread := a_spread
			speed := a_speed
			aiming := a_aiming
		end

feature -- Access

	name: STRING
	filename: STRING
	description: STRING
	bullet: STRING
	health: DOUBLE
	count: INTEGER
	firerate: INTEGER
	price: INTEGER
	spread: DOUBLE
	speed: DOUBLE
	aiming: BOOLEAN

end
