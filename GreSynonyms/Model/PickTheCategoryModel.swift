//
//  PickTheCategoryModel.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/19/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class PickTheCategoryModel {
    
    var categories: [String]
    var wordList: [WordClass]
    var synonymsDict: [String:[WordClass]]
    
    init (chosenCategories: [String], synonymsDict: [String: [WordClass]]) {
        self.categories = chosenCategories
        self.synonymsDict = synonymsDict
        var allWordsList: [WordClass] = []
        for category in chosenCategories {
            allWordsList += synonymsDict[category]!
        }
        self.wordList = Utilities.shuffleWordList(lst: allWordsList)
    }
    
}
