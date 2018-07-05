//
//  SynonymsBank.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

let FILE_NAME = "SynonymsData"

class SynonymsBank {
    
    var synonymsDict: [String: [WordClass]] = [:]
    var categories: [String]
    init() {
        let csvString = Utilities.readDataFromCSV(fileName: FILE_NAME)
        guard let rows = csvString?.components(separatedBy: "\r") else {
            print("Faied to initialize")
            categories = []
            synonymsDict = ["":[]]
            return
        }
        categories = []
        for i in 0..<rows.count {
            let row = rows[i].components(separatedBy: ",")
            let wordCategory = row[0]
            categories.append(wordCategory)
            let wordList = row[1..<row.count].filter {$0 != ""}
            var wordObjectList:[WordClass] = []
            for word in wordList {
                wordObjectList.append(WordClass(word: word, answer: wordCategory))
            }
            synonymsDict[wordCategory] = wordObjectList
        }
    }
}
