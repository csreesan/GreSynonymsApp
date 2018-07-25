//
//  MeaningObject.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/21/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class MeaningObject {
    let partOfSpeech: String
    let meaning: String
    let example: String
    let synonymId: Int
    
    init(partOfSpeech: String, meaning: String, example: String, synonymId: Int) {
        self.partOfSpeech = partOfSpeech
        self.meaning = meaning
        self.example = example
        self.synonymId = synonymId
    }
    
    func getSynonyms() -> [WordObject] {
        return DictionaryDatabaseUtility.getSynonymsFromSynID(synId: self.synonymId)!
    }
}
