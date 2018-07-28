//
//  YesNoGameObject.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/19/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class YesNoGameObject {
    
    let MULTIPLIER = 2.1
    let mainLabel: String
    var shuffledWordList: [WordObject] = []
    var synonymObjectList: [SynonymObject] = []
    var answerKey: [Int] = []
    var gameObjectType: GameObjectType = .synonym
    var mainID: Int = 0
    
    init(wordObject: WordObject) {
        self.mainLabel = wordObject.word
        self.shuffledWordList = getShuffledWordListFromWordObject(wordObject: wordObject)
        self.synonymObjectList = wordObject.getSynonymObjectList()
        self.answerKey = synonymObjectList.map {$0.id}
        self.gameObjectType = .word
        self.mainID = wordObject.id
    }
    
    convenience init(mainID: Int, mainType: String) {
        if mainType == GameObjectType.synonym.rawValue {
            let synonymObject = SynonymObject(id: mainID)
            self.init(synonymObject: synonymObject)
        } else if mainType == GameObjectType.word.rawValue {
            let wordObject = DictionaryDatabaseUtility.getWordObjectFromID(id: mainID)!
            self.init(wordObject: wordObject)
        } else {
            fatalError("Incorrect main type string for game object")
        }
    }
    
    init(synonymObject: SynonymObject) {
        self.mainLabel = synonymObject.label
        self.shuffledWordList = getShuffledWordListFromSynonymObject(synonymObject: synonymObject)
        self.synonymObjectList = [synonymObject]
        self.answerKey = synonymObjectList.map {$0.id}
        self.gameObjectType = .synonym
        self.mainID = synonymObject.id
    }
    
    func getShuffledWordListFromWordObject(wordObject: WordObject) -> [WordObject] {
        let synonyms = wordObject.getSynonyms()
        let allWordsShuffled = Utility.shuffleWordList(lst: DictionaryDatabaseUtility.getAllWords())
        let total: Int = Int(Double(synonyms.count) * MULTIPLIER)
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
        let allWordsShuffled = Utility.shuffleWordList(lst: DictionaryDatabaseUtility.getAllWords())
        let total: Int = Int(Double(synonyms.count) * MULTIPLIER)
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

struct ContinueGameHelperObject {
    
    let wordList: [WordObject]
    let score: Int
    let currIndex: Int
    let correctWords: [WordObject]
    let wrongWords: [WordObject]
    
    init (wordListID: [Int], score: Int, currIndex: Int, correctIDs: [Int], wrongIDs: [Int]) {
        self.wordList = Utility.getWordObjectsFromIDList(idList: wordListID)
        self.score = score
        self.currIndex = currIndex
        self.correctWords = Utility.getWordObjectsFromIDList(idList: correctIDs)
        self.wrongWords = Utility.getWordObjectsFromIDList(idList: wrongIDs)
    }
}



