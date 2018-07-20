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
    static let synonym_id = Expression<Int>("synonym_id")
    static let label = Expression<String>("label")
}

class DatabaseUtility {
    
    static var database: Connection? = nil
    
    static let wordsTable = Table("words")
    static let synonymsTable = Table("synonyms")
    
    
    static func getAllWords() -> [WordObject] {
        var wordArr: [WordObject] = []
        do {
            let words = try self.database!.prepare(self.wordsTable)
            print("words table")
            for word in words {
                wordArr.append(WordObject(id: word[Column.id], word: word[Column.word], partOfSpeech: word[Column.part_of_speech], meaning: word[Column.meaning], example: word[Column.example], synonymId: word[Column.synonym_id]))
            }
        } catch {
            print(error)
        }
        return wordArr
    }
    
    static func getSynonymsList(wordId: Int) -> [WordObject]? {
        let synGroupID = getSynonymGroupID(wordId: wordId)!
        return getSynonyms(synId: synGroupID, wordId: wordId)
    }
    
    static func getSynonyms(synId: Int, wordId: Int? = nil) -> [WordObject]? {
        var arr: [WordObject] = []
        let synonymsOfWord: Table
        if let filterWordId = wordId {
            synonymsOfWord = wordsTable.where(Column.synonym_id == synId && Column.id != filterWordId)
        } else {
            synonymsOfWord = wordsTable.where(Column.synonym_id == synId)
        }
        let synSet: AnySequence<Row>
        do {
            synSet = try self.database!.prepare(synonymsOfWord)
        } catch {
            print(error)
            return nil
        }
        for syn in synSet {
            arr.append(WordObject(id: syn[Column.id], word: syn[Column.word], partOfSpeech: syn[Column.part_of_speech], meaning: syn[Column.meaning], example: syn[Column.example], synonymId: syn[Column.synonym_id]))
        }
        return arr
    }
    
    static func getSynonymLabel(synId: Int) -> String? {
        let synonymRowTable = synonymsTable.where(Column.id == synId)
        do {
            let synonymRow = try self.database!.pluck(synonymRowTable)
            return synonymRow![Column.label]
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getSynonymGroupID(wordId: Int) -> Int? {
        do {
            let wordRowTable = self.wordsTable.where(Column.id == wordId)
            let wordRow = try self.database!.pluck(wordRowTable)
            let synGroupID = wordRow![Column.synonym_id]
            return synGroupID
        } catch {
            print(error)
            return nil
        }
    }
    
    static func getWordObjectFromID(id: Int, database: Connection) -> WordObject? {
        do {
            let wordRowQuery = self.wordsTable.where(wordsTable[Column.id] == id)
            guard let wordRow = try self.database!.pluck(wordRowQuery) else {
                throw databaseError.noResultRows
            }
            return WordObject(id: wordRow[Column.id], word: wordRow[Column.word], partOfSpeech: wordRow[Column.part_of_speech], meaning: wordRow[Column.meaning], example: wordRow[Column.example], synonymId: wordRow[Column.synonym_id])
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
                arr.append(SynonymObject(id: synonym[Column.id], label: synonym[Column.label]))
            }
            return arr
        } catch {
            print(error)
            return nil
        }
    }
}
