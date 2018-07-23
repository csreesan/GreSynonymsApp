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

class Column {
    static let id = Expression<Int>("id")
    static let word = Expression<String>("word")
    static let part_of_speech = Expression<String>("part_of_speech")
    static let meaning = Expression<String>("meaning")
    static let example = Expression<String>("example")
    static let word_id = Expression<Int>("word_id")
    static let synonym_id = Expression<Int>("synonym_id")
    static let label = Expression<String>("label")
}

class DatabaseUtility {
    
    static var database: Connection? = nil
    
    static let wordsTable = Table("words")
    static let synonymsTable = Table("synonyms")
    static let meaningsTable = Table("meanings")
    
    
    static func getAllWords() -> [WordObject] {
        var wordArr: [WordObject] = []
        do {
            let words = try self.database!.prepare(self.wordsTable)
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
            let meaningsForWord = self.meaningsTable.where(wordId == Column.word_id)
            let meaningRows = try self.database!.prepare(meaningsForWord)
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
        for synID in synGroupIDs {
            guard let synonyms = getSynonymsFromSynID(synId: synID, excludeWordId: wordId) else {
                return nil
            }
            synonymsList.append(contentsOf: synonyms)
        }
        return synonymsList
    }
    
    static func getSynonymsFromSynID(synId: Int, excludeWordId: Int? = nil) -> [WordObject]? {
        var wordIDSet: Set<Int> = []
        var wordArr: [WordObject] = []
        let meaningsRows: Table
        if let excludeWordId = excludeWordId {
            meaningsRows = self.meaningsTable.where(Column.synonym_id == synId && Column.id != excludeWordId)
        } else {
            meaningsRows = self.meaningsTable.where(Column.synonym_id == synId)
        }
        do {
            let meanings = try self.database!.prepare(meaningsRows)
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
        let synonymRowTable = self.synonymsTable.where(Column.id == synId)
        do {
            let synonymRow = try self.database!.pluck(synonymRowTable)
            return synonymRow![Column.label]
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getSynonymGroupIDList(wordId: Int) -> [Int]? {
        do {
            var synonymGroupArr: [Int] = []
            let meaningsForWords = self.meaningsTable.where(Column.word_id == wordId)
            let meaningRows = try self.database!.prepare(meaningsForWords)
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
            let wordRowQuery = self.wordsTable.where(wordsTable[Column.id] == id)
            guard let wordRow = try self.database!.pluck(wordRowQuery) else {
                throw databaseError.noResultRows
            }
            return WordObject(id: wordRow[Column.id], word: wordRow[Column.word])
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getAllSynonymObjects() -> [SynonymObject]? {
        do {
            var arr: [SynonymObject] = []
            let synonyms = try self.database!.prepare(self.synonymsTable)
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
