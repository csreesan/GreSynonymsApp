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
    let partOfSpeech: String
    let meaning: String
    let example: String
    let synonymId: Int
    init(id: Int, word: String, partOfSpeech: String, meaning: String, example: String, synonymId: Int) {
        self.id = id
        self.word = word
        self.partOfSpeech = partOfSpeech
        self.meaning = meaning
        self.example = example
        self.synonymId = synonymId
    }
    
    func getSynonyms() -> [WordObject] {
        return DatabaseUtility.getSynonyms(synId: self.synonymId, wordId: self.id)!
    }
    
    func getSynonymObject() -> SynonymObject {
        let label = DatabaseUtility.getSynonymLabel(synId: self.synonymId)!
        return SynonymObject(id: DatabaseUtility.getSynonymGroupID(wordId: self.id)!, label: label)
    }
}
