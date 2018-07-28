//
//  SQLStrings.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/26/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

struct SynonymSQLString {

    static let synonymAllTimeCorrectPercentage =
    """
    WITH correct(synonym_id, num) AS
    (
    SELECT  attempts.synonym_id, CAST(COUNT(*) as REAL)
    FROM attempts
    WHERE result = 1
    GROUP BY attempts.synonym_id
    ),
    total(synonym_id, num) AS
    (
    SELECT attempts.synonym_id, CAST (COUNT(*) as REAL)
    FROM attempts
    GROUP BY attempts.synonym_id
    )
    SELECT correct.synonym_id, correct.num/total.num AS ratio
    FROM correct
    JOIN total
    ON correct.synonym_id = total.synonym_id
    ORDER BY ratio;
    """
    
    static let synonymRecentCorrectPercentage =
    """
    WITH
    top_ten(synonym_id, result, rank) as
        (
            SELECT attempts.synonym_id, attempts.result, COUNT(helper.timestamp) AS rank
            FROM attempts
            LEFT JOIN attempts AS helper
             ON attempts.synonym_id = helper.synonym_id AND attempts.timestamp < helper.timestamp
            GROUP BY attempts.synonym_id, attempts.result, attempts.timestamp
            HAVING COUNT(helper.timestamp) < 30
            ORDER BY attempts.synonym_id, attempts.timestamp DESC
        ),
    total(synonym_id, num) as
        (
            SELECT top_ten.synonym_id, CAST(COUNT(*) AS REAL) FROM top_ten GROUP BY top_ten.synonym_id
        ),
    correct(synonym_id, num) as
        (
        SELECT top_ten.synonym_id, CAST(COUNT(*)  AS REAL) FROM top_ten WHERE top_ten.result = 1 GROUP BY top_ten.synonym_id
        )
    SELECT correct.synonym_id, correct.num / total.num AS ratio FROM correct JOIN total ON correct.synonym_id = total.synonym_id
    ORDER BY ratio;
    """
    
    static let synonymAverageCorrectPercentageWhenCompleted =
    """
    SELECT synonym_id, AVG(CAST(correct_num AS REAL) / CAST(total_num AS REAL)) AS ratio
    FROM completed_games GROUP BY synonym_id ORDER BY ratio;
    """
    
    static let synonymLatestCorrectPercentageWhenCompleted =
    """
    SELECT a.synonym_id,  (CAST(a.correct_num AS REAL) / CAST(a.total_num AS REAL)) AS ratio
    FROM completed_games AS a
    LEFT JOIN completed_games AS b
        ON a.synonym_id = b.synonym_id AND a.timestamp < b.timestamp
    WHERE b.synonym_id IS NULL
    ORDER BY ratio;
    """
    
    static let synonymTimeLastAttempted =
    """
    SELECT synonym_id, MIN((julianday('now') - julianday(timestamp)) * 24 * 60) as latest_time
    FROM attempts
    GROUP BY synonym_id
    ORDER BY latest_time DESC;
    """
    
    static let synonymTimeLastCompleted =
    """
    SELECT synonym_id, MIN((julianday('now') - julianday(timestamp)) * 24 * 60) as latest_time
    FROM completed_games
    GROUP BY synonym_id
    ORDER BY latest_time DESC;
    """
}

struct WordsTableSQLString {
    static let wordAllTimeCorrectPercentage =
    """
    WITH correct(word_id, num) AS
        (
            SELECT  attempts.word_id, CAST(COUNT(*) as REAL)
            FROM attempts
            WHERE result = 1
            GROUP BY attempts.word_id
        ),
    total(word_id, num) AS
        (
            SELECT attempts.word_id, CAST (COUNT(*) as REAL)
             FROM attempts
             GROUP BY attempts.word_id
        )
    SELECT correct.word_id, correct.num/total.num AS ratio
    FROM correct
    JOIN total
    ON correct.word_id = total.word_id
    ORDER BY ratio;
    """
    
    static let wordRecentCorrectPercentage =
    """
    WITH
    top_ten(word_id, result, rank) as
    (
    SELECT attempts.word_id, attempts.result, COUNT(helper.timestamp) AS rank
    FROM attempts
    LEFT JOIN attempts AS helper
    ON attempts.word_id = helper.word_id AND attempts.timestamp < helper.timestamp
    GROUP BY attempts.word_id, attempts.result, attempts.timestamp
    HAVING COUNT(helper.timestamp) < 10
    ORDER BY attempts.word_id, attempts.timestamp DESC
    ),
    total(word_id, num) as
    (
    SELECT top_ten.word_id, CAST(COUNT(*) AS REAL) FROM top_ten GROUP BY top_ten.word_id
    ),
    correct(word_id, num) as
    (
    SELECT top_ten.word_id, CAST(COUNT(*)  AS REAL) FROM top_ten WHERE top_ten.result = 1 GROUP BY top_ten.word_id
    )
    SELECT correct.word_id, correct.num / total.num AS ratio FROM correct JOIN total ON correct.word_id = total.word_id
    ORDER BY ratio;
    """
    
    static let wordTimeLastSeen =
    """
    SELECT word_id, MIN((julianday('now') - julianday(timestamp)) * 24 * 60) as latest_time
    FROM attempts
    GROUP BY word_id
    ORDER BY latest_time DESC;
    """
    
    static let wordTimeLastCorrecct =
    """
    SELECT word_id, MIN((julianday('now') - julianday(timestamp)) * 24 * 60) as latest_time
    FROM attempts WHERE result = 1
    GROUP BY word_id
    ORDER BY latest_time DESC;
    """
}
