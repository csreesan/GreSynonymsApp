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
    static let labels: [String] = [SynonymPickerOptions.alphabetical.rawValue,
                                   SynonymPickerOptions.latestCorrectPercentageWhenCompleted.rawValue,
                                   SynonymPickerOptions.averageCorrectPercentageWhenCompleted.rawValue,
                                   SynonymPickerOptions.allTimeCorrectPercentage.rawValue,
                                   SynonymPickerOptions.recentCorrectPercentage.rawValue,
                                   SynonymPickerOptions.timeLastAttempted.rawValue,
                                   SynonymPickerOptions.timeLastCompleted.rawValue]
}

enum WordPickerOptions: String {
    case alphabetical = "Alphabetical"
    case allTimeCorrectPercentage = "All Time Correct %"
    case recentCorrectPercentage = "Recent Correct %"
    case timeLastSeen = "Time Last Seen"
    case timeLastCorrect = "Time Last Correct"
    static let labels: [String] = [WordPickerOptions.alphabetical.rawValue,
                                   WordPickerOptions.allTimeCorrectPercentage.rawValue,
                                   WordPickerOptions.recentCorrectPercentage.rawValue,
                                   WordPickerOptions.timeLastSeen.rawValue,
                                   WordPickerOptions.timeLastCorrect.rawValue]
}

enum SpecialCateogryType: String {
    case correct = "What you got right!"
    case wrong = "What you got wrong!"
    case allQuestions = "All questions!"
}

enum StatType {
    case integer
    case time
    case percentage
}

enum HowToSection: String {
    case basics = "Basics"
    case testing = "Testing"
    case useStats = "Use Stats"
    case flashcards = "Flashcards"
    
    func label() -> String {
        return self.rawValue
    }
    
    func explanation() -> String {
        switch  self {
        case .basics:
            return """
            1. Learn the words in groups in “STUDY”:
            pick a synonym group and see the words and their meaning!\n
            2. Test yourself in “TEST”:
            Pick the synonym you want to test > press “Yep!” if the word you see belong in the group, “Nope!” otherwise \n
            3. Once you finish the question or end the test, see your results!
            """
        case .testing:
            return """
            Two Types of Tests\n
            1. Test by synonym group through "STUDY" section: synonym name appears on top, if the word that appears below it belongs to the synonym group press "Yep!", otherwise "Nope!" \n
            2. Test by word through "Test" button on top of a word's flashcard: word to test appears on top, if the word below it is a syonym of that word press "Yep!", otherwise "Nope!"\n
            At the end of the test the results will appear, you can see what words belong to the synonyms groups you were testing, what words were tested, and what you got right and wrong.
            """
        case .useStats:
            return """
            To assist you in chosing what to test or what to brush up on, toggle is provided to allow you to see your categories or words in different orders depending on the stats. \n
            At the bottom of the page in "TEST", "STUDY", and "All Words", you can pick any order you want and the stats will appear, the default is alphabetical.
            """
        case .flashcards:
            return """
            With flashcards you can toggle between meaning and synonyms using the tab bar at the bottom of the page.\n
            In the meaning section, the arrows at the bottom allows you to navigate through the set without having to go back to the table.\n
            If the word has more than one meaning, "next meaning" button will appear. The synonym section will show only synonyms that belong to that specific meaning.
            """
        }
    }
}
