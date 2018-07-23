//
//  WordObject.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/7/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class WordObject {
    let id: Int
    let word: String
    var meaningList: [MeaningObject] = []
    init(id: Int, word: String) {
        self.id = id
        self.word = word
        self.meaningList = getMeaningList()
    }
    
    func getSynonyms() -> [WordObject] {
        return DatabaseUtility.getSynonymsOfWord(wordId: self.id)!
    }
    
    func getSynonymObjectList() -> [SynonymObject] {
        var synonymObjectList: [SynonymObject] = []
        for synonymID in DatabaseUtility.getSynonymGroupIDList(wordId: self.id)! {
            synonymObjectList.append(SynonymObject(id: synonymID))
        }
        return synonymObjectList
    }
    
    func getMeaningList() -> [MeaningObject] {
        return DatabaseUtility.getMeaningObjectList(wordId: self.id)!
    }
    
    func getSynonymIDList() -> [Int] {
        return getSynonymObjectList().map {$0.id}
    }
}
