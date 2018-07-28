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
    var stat: String {get}
}


class SynonymObject: FlashCardCategory {
    let id: Int
    let label: String
    var stat: String
    init(id: Int, stat: String="") {
        self.id = id
        self.label = DictionaryDatabaseUtility.getSynonymLabel(synId: self.id)!
        self.stat = stat
    }
    
    func getLabel() -> String {
        return self.label
    }
    
    func getWords() -> [WordObject] {
        return DictionaryDatabaseUtility.getSynonymsFromSynID(synId: self.id)!
    }
}

struct AllWordsCategoryObject: FlashCardCategory {
    var stat: String = ""
    func getLabel() -> String {
        return "All Words"
    }
    func getWords() -> [WordObject] {
        return DictionaryDatabaseUtility.getAllWords()
    }
}

class SpecialCateogryObject: FlashCardCategory {
    let stat:String
    let label: String
    let wordList: [WordObject]
    init(type: SpecialCateogryType, wordList: [WordObject]) {
        self.label = type.rawValue
        self.wordList = wordList
        self.stat = String(wordList.count)
    }
    
    func getLabel() -> String {
        return self.label
    }
    
    func getWords() -> [WordObject] {
        return self.wordList
    }
}

