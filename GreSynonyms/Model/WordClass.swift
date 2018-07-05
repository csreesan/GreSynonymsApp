//
//  WordClass.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/4/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation


class WordClass {

    let word: String
    let answer: String
    
    init(word: String, answer: String) {
        self.word = word
        self.answer = answer
    }
    
    func getWord() -> String {
        return word
    }
    
    func getAnswer() -> String {
        return answer
    }
}
