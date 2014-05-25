note
	description	: "[
					War of Raekidion - A database connexion for accessing highscores
					A {HIGHSCORE} is a connexion to the {DATABASE_MANAGER} specifically 
					made to access and write highscore data.
				]"
	author		: "François Allard (binarmorker) and Marc-Antoine Renaud (Learz)"
	date		: "$Date: May 23 2014$"
	revision	: "$Revision: 1$"

class
	HIGHSCORE

inherit
	DATABASE_MANAGER_SHARED

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		do
			database := connexion.database
			create highscores_list.make

			if highscores (1).count = 0 then
				fill_default_highscores
			end
		end

feature -- Access

	highscores (a_number: INTEGER): LINKED_LIST [TUPLE [STRING, INTEGER]]
		-- Return the best `a_number' scores from `database'
		local
			l_query: SQLITE_QUERY_STATEMENT
		do
			highscores_list.wipe_out
			create l_query.make ("SELECT name, score FROM scores ORDER BY score DESC LIMIT ?1;", database)
			check l_query_is_compiled: l_query.is_compiled end
			l_query.execute_with_arguments (agent fill_highscores, [a_number])
			Result := highscores_list
		end

feature -- Element change

	set_highscore (a_name: STRING; a_score: INTEGER)
		-- Add a score to `database' in the form of `a_name' and `a_score'
		local
			l_insert: SQLITE_INSERT_STATEMENT
		do
			create l_insert.make ("INSERT INTO scores (name, score) VALUES (?1, ?2);", database)
			check l_insert_is_compiled: l_insert.is_compiled end
			database.begin_transaction (False)
			l_insert.execute_with_arguments ([a_name, a_score])
			database.commit
		end

	fill_default_highscores
		-- Add default scores to `database'
		do
			set_highscore ("AAA", 500000)
			set_highscore ("AAA", 250000)
			set_highscore ("AAA", 100000)
			set_highscore ("AAA", 50000)
			set_highscore ("AAA", 25000)
			set_highscore ("AAA", 10000)
			set_highscore ("AAA", 5000)
		end


feature {NONE} -- Implementation

	database: SQLITE_DATABASE
		-- The database to use

	highscores_list: LINKED_LIST [TUPLE [STRING, INTEGER]]
		-- The list of highscores

	fill_highscores (a_row: SQLITE_RESULT_ROW): BOOLEAN
		-- Fill `highscores_list' with `highscores'
		do
			highscores_list.finish
			highscores_list.extend ([a_row.string_value (1), a_row.integer_value (2)])
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
