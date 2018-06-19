//
//  SynonymsBank.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

let FILE_NAME = "SynonymsList"

class SynonymsBank {
    
    var synonymsDict: [String: [String]] = [:]
    var categories: [String]
    init() {
        let csvString = Utilities.readDataFromCSV(fileName: FILE_NAME)
        guard let rows = csvString?.components(separatedBy: "\n") else {
            print("Faied to initialize")
            categories = []
            synonymsDict = ["":[""]]
            return
        }
        categories = rows[0].components(separatedBy: ",")
        for i in 1..<categories.count {
            synonymsDict[categories[i]] = []
        }
        for r in 1..<rows.count {
            for i in 1..<categories.count {
                
            }
        }
    }
}
