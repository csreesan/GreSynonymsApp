//
//  Enums.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/26/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation


enum GameObjectType: String {
    case synonym
    case word
}

enum TableType {
    case synonyms
    case words
    case endOfGame
}

enum SynonymPickerOptions: String {
    case alphabetical = "Alphabetical"
    case allTimeCorrectPercentage = "All Time Correct %"
    case recentCorrectPercentage = "Recent Correct %"
    case averageCorrectPercentageWhenCompleted = "Avg. Correct % When Completed"
    case latestCorrectPercentageWhenCompleted = "Latest Correct % When Completed"
    case timeLastAttempted = "Time Last Attempted"
    case timeLastCompleted = "Time Last Completed"
    static let labels: [String] = [SynonymPickerOptions.alphabetical.rawValue, SynonymPickerOptions.allTimeCorrectPercentage.rawValue, SynonymPickerOptions.recentCorrectPercentage.rawValue, SynonymPickerOptions.averageCorrectPercentageWhenCompleted.rawValue,
                                   SynonymPickerOptions.latestCorrectPercentageWhenCompleted.rawValue, SynonymPickerOptions.timeLastAttempted.rawValue, SynonymPickerOptions.timeLastCompleted.rawValue]
}

enum WordPickerOptions: String {
    case alphabetical = "Alphabetical"
    case allTimeCorrectPercentage = "All Time Correct %"
    case recentCorrectPercentage = "Recent Correct %"
    case timeLastSeen = "Time Last Seen"
    case timeLastCorrect = "Time Last Correct"
    static let labels: [String] = [WordPickerOptions.alphabetical.rawValue, WordPickerOptions.allTimeCorrectPercentage.rawValue, WordPickerOptions.recentCorrectPercentage.rawValue, WordPickerOptions.timeLastSeen.rawValue, WordPickerOptions.timeLastCorrect.rawValue]
}

enum SpecialCateogryType: String {
    case yourHits = "Your Hits"
    case yourMisses = "Your Misses"
    case yourChallenges = "Your Challenges"
}

enum StatType {
    case integer
    case time
    case percentage
}
