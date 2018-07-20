//
//  YesNoGameObject.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/19/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class YesNoGameObject {
    
    let chosenWord: WordObject
    var shuffledWordList: [WordObject] = []
    
    init(chosenWordObject: WordObject) {
        self.chosenWord = chosenWordObject
        self.shuffledWordList = getShuffledWordList()
    }
    
    func getShuffledWordList() -> [WordObject] {
        let synonyms = chosenWord.getSynonyms()
        let allWordsShuffled = Utility.shuffleWordList(lst: DatabaseUtility.getAllWords())
        let total: Int = Int(Double(synonyms.count) * 1.5)
        var wordList = synonyms
        var index = 0
        while wordList.count < total && index < allWordsShuffled.count {
            let word = allWordsShuffled[index]
            if word.id != self.chosenWord.id && !synonyms.contains {$0.id == word.id} {
                wordList.append(word)
            }
            index += 1
        }
        return Utility.shuffleWordList(lst: wordList)
    }
    
    func getMainWordLabel() -> String {
        return self.chosenWord.word
    }
    
}
