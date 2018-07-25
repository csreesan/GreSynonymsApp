//
//  UserDatabaseUtility.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/24/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation
import SQLite


class UserDatabaseUtility {
    static var database: Connection? = nil
    
    static let continueTable = Table("continue")
    static let attemptsTable = Table("attempts")
    
    
    static func createUserTables() {
        let createContinueTable = UserDatabaseUtility.continueTable.create { (table) in
            table.column(Column.in_progress)
            table.column(Column.word_list)
            table.column(Column.score)
            table.column(Column.main_type)
            table.column(Column.main_id)
            table.column(Column.curr_index)
            table.column(Column.correct_ids)
            table.column(Column.wrong_ids)
        }
        
        do {
            try database!.run(createContinueTable)
            print("continue table created!!")
        } catch {
            print(error)
        }
        createAttemptsTable()
    }
    
    static func createAttemptsTable() {
        let createAttemptsTable = UserDatabaseUtility.attemptsTable.create { (table) in
            table.column(Column.timestamp)
            table.column(Column.synonym_id)
            table.column(Column.word_id)
            table.column(Column.result)
        }
        
        do {
            try database!.run(createAttemptsTable)
            print("attempts table created!!")
            insertToContinue(inProgress: 0, wordList: "0", score: 0, mainType: "HI!", mainID: 0, currID: 0, correctIDs: "0", wrongIDs: "0")
        } catch {
            print(error)
        }
    }
    static func insertToContinue(inProgress: Int, wordList: String, score: Int, mainType: String, mainID: Int, currID: Int, correctIDs: String, wrongIDs: String) {
        let insertContinue = self.continueTable.insert(Column.in_progress <- inProgress, Column.main_type <- mainType, Column.word_list <- wordList, Column.score <- score, Column.main_id <- mainID, Column.curr_index <- currID, Column.correct_ids <- correctIDs, Column.wrong_ids <- wrongIDs)
        do {
            try UserDatabaseUtility.database!.run(insertContinue)
            print("Insert into cont!")
        } catch {
            print(error)
        }
    }
    
    static func insertToAttempts(timeStamp: Date, synonymID: Int, wordID: Int, result: Int) {
        let insertAttempt = UserDatabaseUtility.attemptsTable.insert(Column.timestamp <- timeStamp, Column.synonym_id <- synonymID, Column.word_id <- wordID, Column.result <- result)
        do {
            try UserDatabaseUtility.database!.run(insertAttempt)
            print("Insert into attempt!")
        } catch {
            print(error)
        }
    }
    
    static func updateContinue(inProgress: Int, wordList: String, score: Int, mainType: String, mainID: Int, currIndex: Int, correctIDs: String, wrongIDs: String) {
        let updateContinue = UserDatabaseUtility.continueTable.update(Column.in_progress <- inProgress, Column.main_type <- mainType, Column.word_list <- wordList, Column.score <- score, Column.main_id <- mainID, Column.curr_index <- currIndex, Column.correct_ids <- correctIDs, Column.wrong_ids <- wrongIDs)
        do {
            try UserDatabaseUtility.database!.run(updateContinue)
            print("UPATE CONT!")
        } catch {
            print(error)
        }
    }
    
    static func getGameProgress() -> (Bool, [Int], Int, String, Int, Int, [Int], [Int])   {
        do {
            let cont = try UserDatabaseUtility.database!.pluck(UserDatabaseUtility.continueTable)
            let inProgress = cont![Column.in_progress] == 1
            let wordList = (cont![Column.word_list].split(separator: ",")).map {Int($0)!}
            let score = cont![Column.score]
            let mainType = cont![Column.main_type]
            let mainID = cont![Column.main_id]
            let currIndex = cont![Column.curr_index]
            let correctIDs = (cont![Column.correct_ids].split(separator: ",")).map {Int($0)!}
            let wrongIDs = (cont![Column.wrong_ids].split(separator: ",")).map {Int($0)!}
            return (inProgress, wordList, score, mainType, mainID, currIndex, correctIDs, wrongIDs)
        } catch {
            print(error)
            fatalError("Failed when checking in progress!")
        }
    }
    
    static func restartAttemptsTable() {
        let dropAttemptsTable = UserDatabaseUtility.attemptsTable.drop()
        do {
            try UserDatabaseUtility.database!.run(dropAttemptsTable)
            print("DROP Attempts table??")
        } catch {
            print(error)
        }
        createAttemptsTable()
    }
    
    static func getSynonymOrderByLastestTime() {
        do {
            let latestTimes = try database!.prepare("SELECT synonym_id, MIN((julianday('now') - julianday(timestamp)) * 24 * 60) as latest_time FROM attempts GROUP BY synonym_id ORDER BY latest_time DESC")
            for latest in latestTimes {
                print("syn_id: \(latest[0]!), time: \(latest[1]!)")
            }
            
        } catch {
            print(error)
        }
    }
}
