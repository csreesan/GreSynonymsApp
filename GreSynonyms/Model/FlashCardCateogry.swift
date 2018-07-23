//
//  FlashCardCategory.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/8/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation


protocol FlashCardCategory {
    func getLabel() -> String
    func getWords() -> [WordObject]
}


class SynonymObject: FlashCardCategory {
    let id: Int
    let label: String
    init(id: Int) {
        self.id = id
        self.label = DatabaseUtility.getSynonymLabel(synId: self.id)!
    }
    
    func getLabel() -> String {
        return self.label
    }
    
    func getWords() -> [WordObject] {
        return DatabaseUtility.getSynonymsFromSynID(synId: self.id)!
    }
}

struct AllWordsCategoryObject: FlashCardCategory {
    
    func getLabel() -> String {
        return "All Words"
    }
    func getWords() -> [WordObject] {
        return DatabaseUtility.getAllWords()
    }
}

class SpecialCateogryObject: FlashCardCategory {
    
    let label: String
    let wordList: [WordObject]
    init(isCorrect: Bool, wordList: [WordObject]) {
        self.label = isCorrect ? "Your Hit": "Your Miss"
        self.wordList = wordList
    }
    
    func getLabel() -> String {
        return self.label
    }
    
    func getWords() -> [WordObject] {
        return self.wordList
    }
}
