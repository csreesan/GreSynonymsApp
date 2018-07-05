//
//  Utilities.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash
import SwiftyJSON

let MW_DICT_URL =  "https://www.dictionaryapi.com/api/v1/references/collegiate/xml/get?"
let MW_DICT_KEY = "adff0372-2a39-459b-b787-708fb71b5943"
let MW_THES_KEY = "6ae27237-ba4b-4206-9556-9a13a84b83f7"

func enumerateIndex(indexer: XMLIndexer) {
    for child in indexer.children {
        //print(child.element!.name)
        if let element = child.element {
            print(element.text)
        }
        enumerateIndex(indexer: child)
    }
}

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
    
    static func shuffleWordList(lst: [WordClass]) -> [WordClass] {
        var result = lst
        var count = lst.count - 1
        
        while(count > 0) {
            let randIndex = Int(arc4random_uniform(UInt32(count)))
            result.swapAt(count, randIndex)
            count -= 1
        }
        return result
    }
    
    static func getDefinition(word: String) {
        let params = ["key": MW_DICT_KEY, "word": word]
        Alamofire.request(MW_DICT_URL, method: .get, parameters: params).response {
            response in
            if let data = response.data {
                let xml = SWXMLHash.parse(data)
                print(xml)
                let dt = xml["entry_list"]["entry"][0]["def"]["dt"].all
                print(dt)
                print(xml["entry_list"]["entry"][0]["def"]["dt"].element?.text ?? "NOPE!!!!")
                print(xml["entry_list"]["entry"][0]["def"]["dt"].children)
                for (_,indexer) in dt.enumerated() {
                    print(indexer.element?.text ?? "NOPE2!!!!")
                    //enumerateIndex(indexer: indexer)
                }
            } else {
                print(response.error ?? "api call failed no error")
            }
        }
    }
}
