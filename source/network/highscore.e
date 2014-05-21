note
	description: "Summary description for {HIGHSCORE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HIGHSCORE

inherit
	DATABASE_CONNECT

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize `Current'
		do
			database := connexion.database
			create highscores_list.make
		end

feature -- Access

	highscores (a_number: INTEGER): LINKED_LIST [TUPLE [STRING, INTEGER]]
		-- Return the best `a_number' scores from `database'
		local
			l_query: SQLITE_QUERY_STATEMENT
		do
			highscores_list.wipe_out
			create l_query.make ("SELECT name, score FROM scores ORDER BY score LIMIT ?1;", database)
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

end
