//
//  YesNoGameObject.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/19/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class YesNoGameObject {
    
    let mainLabel: String
    var shuffledWordList: [WordObject] = []
    var synonymObjectList: [SynonymObject] = []
    var correctIDs: [Int] = []
    
    init(wordObject: WordObject) {
        self.mainLabel = wordObject.word
        self.shuffledWordList = getShuffledWordListFromWordObject(wordObject: wordObject)
        self.synonymObjectList = wordObject.getSynonymObjectList()
        self.correctIDs = synonymObjectList.map {$0.id}
    }
    
    init(synonymObject: SynonymObject) {
        self.mainLabel = synonymObject.label
        self.shuffledWordList = getShuffledWordListFromSynonymObject(synonymObject: synonymObject)
        self.synonymObjectList = [synonymObject]
        self.correctIDs = synonymObjectList.map {$0.id}
    }
    
    func getShuffledWordListFromWordObject(wordObject: WordObject) -> [WordObject] {
        let synonyms = wordObject.getSynonyms()
        let allWordsShuffled = Utility.shuffleWordList(lst: DatabaseUtility.getAllWords())
        let total: Int = Int(Double(synonyms.count) * 1.5)
        var wordList = synonyms
        var index = 0
        while wordList.count < total && index < allWordsShuffled.count {
            let word = allWordsShuffled[index]
            if word.id != wordObject.id && !synonyms.contains {$0.id == word.id} {
                wordList.append(word)
            }
            index += 1
        }
        return Utility.shuffleWordList(lst: wordList)
    }
    
    func getShuffledWordListFromSynonymObject(synonymObject: SynonymObject) -> [WordObject] {
        let synonyms = synonymObject.getWords()
        let allWordsShuffled = Utility.shuffleWordList(lst: DatabaseUtility.getAllWords())
        let total: Int = Int(Double(synonyms.count) * 2.2)
        var wordList = synonyms
        var index = 0
        while wordList.count < total && index < allWordsShuffled.count {
            let word = allWordsShuffled[index]
            if !synonyms.contains {$0.id == word.id} {
                wordList.append(word)
            }
            index += 1
        }
        return Utility.shuffleWordList(lst: wordList)
    }
}



