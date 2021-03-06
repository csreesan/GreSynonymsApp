//
//  Constants.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/24/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation
import SQLite

struct Column {
    static let id = Expression<Int>("id")
    static let word = Expression<String>("word")
    static let part_of_speech = Expression<String>("part_of_speech")
    static let meaning = Expression<String>("meaning")
    static let example = Expression<String>("example")
    static let word_id = Expression<Int>("word_id")
    static let synonym_id = Expression<Int>("synonym_id")
    static let label = Expression<String>("label")
    
    static let in_progress = Expression<Int>("in_progress")
    static let word_list = Expression<String>("word_list")
    static let score = Expression<Int>("score")
    static let main_type = Expression<String>("main_type")
    static let main_id = Expression<Int>("main_id")
    static let curr_index = Expression<Int>("curr_index")
    static let correct_ids = Expression<String>("correct_ids")
    static let wrong_ids = Expression<String>("wrong_ids")
    
    static let timestamp = Expression<Date>("timestamp")
    static let result = Expression<Int>("result")
    
    static let latest_time = Expression<Date>("latest_time")
    
    static let correct_num = Expression<Int>("correct_num")
    static let total_num = Expression<Int>("total_num")
 }

struct Constants {
    
    static let toYesNoGameSegue = "toYesNoGame"
    static let toWordsSegue = "toWords"
    static let toCategoryControllerSegue = "toCategoryController"
    static let toFlashSegue = "toFlash"
    static let toHowToSegue = "toHowTo"

    static let flashCardsMainLabel = "Flash Cards"
    static let categoryToTestLabel = "Choose Cateogry to Test"
    static let endOfGameLabel = "Game Result"
    static let allWordsLabel = "All Words"
}


