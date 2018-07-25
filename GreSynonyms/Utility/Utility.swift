//
//  Utilities.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Utility {
    
    static func shuffleWordList(lst: [WordObject]) -> [WordObject] {
        var result = lst
        var count = lst.count - 1
        
        while(count > 0) {
            let randIndex = Int(arc4random_uniform(UInt32(count)))
            result.swapAt(count, randIndex)
            count -= 1
        }
        return result
    }

    static func getWordObjectsFromIDList(idList: [Int]) -> [WordObject] {
        var wordObjects: [WordObject] = []
        for id in idList {
            wordObjects.append(DictionaryDatabaseUtility.getWordObjectFromID(id: id)!)
        }
        return wordObjects
    }
}
