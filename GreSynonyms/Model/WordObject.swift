//
//  WordObject.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/7/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class WordObject: FlashCardCategory {
    
    let id: Int
    let word: String
    var stat: String
    var meaningList: [MeaningObject] = []
    
    init(id: Int, word: String) {
        self.id = id
        self.word = word
        self.stat = ""
        self.meaningList = getMeaningList()
    }
    
    init(id: Int, stat: String) {
        self.id = id
        self.word = DictionaryDatabaseUtility.getWordStringFromID(id: id)!
        self.stat = stat
        self.meaningList = getMeaningList()
    }
    
    func getSynonyms() -> [WordObject] {
        return DictionaryDatabaseUtility.getSynonymsOfWord(wordId: self.id)!
    }
    
    func getSynonymObjectList() -> [SynonymObject] {
        var synonymObjectList: [SynonymObject] = []
        for synonymID in DictionaryDatabaseUtility.getSynonymGroupIDList(wordId: self.id)! {
            synonymObjectList.append(SynonymObject(id: synonymID))
        }
        return synonymObjectList
    }
    
    func getMeaningList() -> [MeaningObject] {
        return DictionaryDatabaseUtility.getMeaningObjectList(wordId: self.id)!
    }
    
    func getSynonymIDList() -> [Int] {
        return getSynonymObjectList().map {$0.id}
    }
    
    // Flash Category
    func getWords() -> [WordObject] {
        return []
    }
    
    func getLabel() -> String {
        return self.word
    }
}
