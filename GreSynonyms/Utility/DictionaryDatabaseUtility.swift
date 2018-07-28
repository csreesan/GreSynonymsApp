//
//  DatabaseUtility.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//
import Foundation
import SQLite



enum databaseError: Error {
    case noResultRows
}



class DictionaryDatabaseUtility {
    
    static var database: Connection? = nil
    
    static let wordsTable = Table("words")
    static let synonymsTable = Table("synonyms")
    static let meaningsTable = Table("meanings")
    
    static func getAllWords() -> [WordObject] {
        var wordArr: [WordObject] = []
        do {
            let words = try database!.prepare(wordsTable.order(Column.word))
            for word in words {
                wordArr.append(WordObject(id: word[Column.id], word: word[Column.word]))
            }
        } catch {
            print(error)
        }
        return wordArr
    }
    
    static func getMeaningObjectList(wordId: Int) -> [MeaningObject]? {
        do {
            var meaningArr: [MeaningObject] = []
            let meaningsForWord = meaningsTable.where(wordId == Column.word_id)
            let meaningRows = try database!.prepare(meaningsForWord)
            for meaningRow in meaningRows {
                meaningArr.append(MeaningObject(partOfSpeech: meaningRow[Column.part_of_speech], meaning: meaningRow[Column.meaning], example: meaningRow[Column.example], synonymId: meaningRow[Column.synonym_id]))
            }
            return meaningArr
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getSynonymsOfWord(wordId: Int) -> [WordObject]? {
        var synonymsList: [WordObject] = []
        guard let synGroupIDs = getSynonymGroupIDList(wordId: wordId) else {
            return nil
        }
        var seenID = Set<Int>()
        for synID in synGroupIDs {
            guard let synonyms = getSynonymsFromSynID(synId: synID, excludeWordId: wordId) else {
                return nil
            }
            for synonym in synonyms {
                if !seenID.contains(synonym.id) {
                    seenID.insert(synonym.id)
                    synonymsList.append(synonym)
                }
            }
        }
        return synonymsList
    }
    
    static func getSynonymsFromSynID(synId: Int, excludeWordId: Int? = nil) -> [WordObject]? {
        var wordIDSet: Set<Int> = []
        var wordArr: [WordObject] = []
        let meaningsRows: Table
        if let excludeWordId = excludeWordId {
            meaningsRows = meaningsTable.where(Column.synonym_id == synId && Column.word_id != excludeWordId).join(wordsTable, on: Column.id == Column.word_id)
        } else {
            meaningsRows = meaningsTable.where(Column.synonym_id == synId).join(wordsTable, on: Column.id == Column.word_id)
        }
        do {
            let meanings = try database!.prepare(meaningsRows.order(Column.word))
            for meaning in meanings {
                let id = meaning[Column.word_id]
                if !wordIDSet.contains(id) {
                    wordArr.append(getWordObjectFromID(id: id)!)
                    wordIDSet.insert(id)
                }
            }
            return wordArr
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getSynonymLabel(synId: Int) -> String? {
        let synonymRowTable = synonymsTable.where(Column.id == synId)
        do {
            let synonymRow = try database!.pluck(synonymRowTable)
            return synonymRow![Column.label]
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getSynonymGroupIDList(wordId: Int) -> [Int]? {
        do {
            var synonymGroupArr: [Int] = []
            let meaningsForWords = meaningsTable.where(Column.word_id == wordId)
            let meaningRows = try database!.prepare(meaningsForWords)
            for meaningRow in meaningRows {
                synonymGroupArr.append(meaningRow[Column.synonym_id])
            }
            return synonymGroupArr
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getWordObjectFromID(id: Int) -> WordObject? {
        do {
            let wordRowQuery = wordsTable.where(wordsTable[Column.id] == id)
            guard let wordRow = try database!.pluck(wordRowQuery) else {
                throw databaseError.noResultRows
            }
            return WordObject(id: wordRow[Column.id], word: wordRow[Column.word])
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getWordStringFromID(id: Int) -> String? {
        do {
            let wordRowQuery = wordsTable.where(wordsTable[Column.id] == id)
            guard let wordRow = try database!.pluck(wordRowQuery) else {
                throw databaseError.noResultRows
            }
            return wordRow[Column.word]
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getAllSynonymObjects() -> [SynonymObject]? {
        do {
            var arr: [SynonymObject] = []
            let synonyms = try database!.prepare(synonymsTable.order(Column.label))
            for synonym in synonyms {
                arr.append(SynonymObject(id: synonym[Column.id]))
            }
            return arr
        } catch {
            print(error)
            return nil
        }
    }
}
