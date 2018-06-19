//
//  Utilities.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation


class Utilities {
    
    static func readDataFromCSV(fileName: String) -> String!{
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            return nil
        }
        do {
            let result = try String(contentsOfFile: filePath, encoding: .utf8)
            return result
        } catch {
            print("Eroor reading file: \(fileName)")
            return nil
        }
    }
}
