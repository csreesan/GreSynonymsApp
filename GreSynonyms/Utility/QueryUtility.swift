//
//  QueryUtility.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/26/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

class QueryUtility {
    
    static let MINUTES_IN_DAY = 60 * 24
    static let MINUTES_IN_HOUR = 60
    static let DAY_THRESHOLD = 2
    static let HOUR_THRESHOLD = 5
    
    static func getOrderedFlashCardObjects(type: TableType, pickerLabel: String) -> [FlashCardCategory] {
        if type == .synonyms {
            return getAllSynonymsInOder(pickerLabel: pickerLabel)
        } else {
            return getAllWordsInOrder(pickerLabel: pickerLabel)
        }
    }
    
    static func getAllWordsInOrder(pickerLabel: String) -> [FlashCardCategory] {
        let alphabeticalList = DictionaryDatabaseUtility.getAllWords()
        let queryString: String
        let valueType: StatType
        switch pickerLabel {
        case WordPickerOptions.alphabetical.rawValue:
            return alphabeticalList
        case WordPickerOptions.allTimeCorrectPercentage.rawValue:
            queryString = WordsTableSQLString.wordAllTimeCorrectPercentage
            valueType = .percentage
        case WordPickerOptions.recentCorrectPercentage.rawValue:
            queryString = WordsTableSQLString.wordRecentCorrectPercentage
            valueType = .percentage
        case WordPickerOptions.timeLastSeen.rawValue:
            queryString = WordsTableSQLString.wordTimeLastSeen
            valueType = .time
        case WordPickerOptions.timeLastCorrect.rawValue:
            queryString = WordsTableSQLString.wordTimeLastCorrecct
            valueType = .time
        default:
            print("Invalid picker view selection")
            return alphabeticalList
        }
        var (orderedList, idSet) = getOrderdListAndIdSet(queryString: queryString, valueType: valueType, type: .words)
        for wordObject in alphabeticalList {
            if !idSet.contains(wordObject.id) {
                wordObject.stat = "NA"
                orderedList.append(wordObject)
            }
        }
        return orderedList
    }
    
    static func getAllSynonymsInOder(pickerLabel: String) -> [FlashCardCategory] {
        let alphabeticalList = DictionaryDatabaseUtility.getAllSynonymObjects()!
        let queryString: String
        let valueType: StatType
        switch pickerLabel {
        case SynonymPickerOptions.alphabetical.rawValue:
            return alphabeticalList
        case SynonymPickerOptions.allTimeCorrectPercentage.rawValue:
            queryString = SynonymSQLString.synonymAllTimeCorrectPercentage
            valueType = .percentage
        case SynonymPickerOptions.recentCorrectPercentage.rawValue:
            queryString = SynonymSQLString.synonymRecentCorrectPercentage
            valueType = .percentage
        case SynonymPickerOptions.averageCorrectPercentageWhenCompleted.rawValue:
            queryString = SynonymSQLString.synonymAverageCorrectPercentageWhenCompleted
            valueType = .percentage
        case SynonymPickerOptions.latestCorrectPercentageWhenCompleted.rawValue:
            queryString = SynonymSQLString.synonymLatestCorrectPercentageWhenCompleted
            valueType = .percentage
        case SynonymPickerOptions.timeLastAttempted.rawValue:
            queryString = SynonymSQLString.synonymTimeLastAttempted
            valueType = .time
        case SynonymPickerOptions.timeLastCompleted.rawValue:
            queryString = SynonymSQLString.synonymTimeLastCompleted
            valueType = .time
        default:
            print("Invalid picker view selection")
            return alphabeticalList
        }
        var (orderedList, idSet) = getOrderdListAndIdSet(queryString: queryString, valueType: valueType, type: .synonyms)
        for synonymObject in alphabeticalList {
            if !idSet.contains(synonymObject.id) {
                synonymObject.stat = "NA"
                orderedList.append(synonymObject)
            }
        }
        return orderedList
    }
    
    static func getOrderdListAndIdSet(queryString: String, valueType: StatType, type: TableType) -> ([FlashCardCategory], Set<Int>) {
        var orderedList: [FlashCardCategory] = []
        var idSet = Set<Int>()
        do {
            let rows = try UserDatabaseUtility.database!.prepare(queryString)
            for row in rows {
                let id = Int(row[0]! as! Int64)
                idSet.insert(id)
                let stat = getStatString(value: row[1]! as! Double, valueType: valueType)
                let flashCatObject: FlashCardCategory
                if type == .synonyms {
                    flashCatObject = SynonymObject(id: id, stat: stat)
                } else {
                    flashCatObject = WordObject(id: id, stat: stat)
                }
                orderedList.append(flashCatObject)
            }
            
        } catch {
            print(error)
        }
        return (orderedList, idSet)
    }
    
    static func getStatString(value: Double, valueType: StatType) -> String {
        switch valueType {
        case .integer:
            return String(value)
        case .percentage:
            return String(Int(value * 100)) + "%"
        case .time:
            return getTimeString(value: value)
        }
    }
    
    static func getTimeString(value: Double) -> String {
        var minutes = Int(value)
        let days = minutes/MINUTES_IN_DAY
        minutes = minutes % MINUTES_IN_DAY
        let hours = minutes/MINUTES_IN_HOUR
        minutes = minutes % MINUTES_IN_HOUR
        if days > 0 {
            if days >= DAY_THRESHOLD {
                return "\(days)d"
            } else {
                return "\(days)d\(hours)h"
            }
        }
        if hours > 0 {
            if hours >= HOUR_THRESHOLD {
                return "\(hours)h"
            } else {
                return "\(hours)h\(minutes)m"
            }
        }
        return "\(minutes)m"
    }
}
