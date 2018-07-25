//
//  MainViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit
import SQLite

protocol CategoryObjectListReceiver {
    func receivedCategoryObjectList(categoryList: [FlashCardCategory])
}

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var contButton: UIButton!
    var yesNoGameObject: YesNoGameObject?
    var continueGameObject: ContinueGameHelperObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilaizeDatabases()
        self.navigationController?.isNavigationBarHidden = true
        self.checkProgress()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.checkProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func yeahNahButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "toYesNoCateogrySelection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCat" {
            var categoryList : [FlashCardCategory] = [AllWordsCategoryObject()]
            categoryList.append(contentsOf: DictionaryDatabaseUtility.getAllSynonymObjects()!)
            let destinationVC = segue.destination as! CateogriesViewController
            destinationVC.receivedCategoryObjectList(categoryList: categoryList)
        }
        if segue.identifier == "toYesNoGame" {
            let destinationVC = segue.destination as! YesNoGameViewController
            destinationVC.continueGameOverride(gameObject: self.yesNoGameObject!, continueObject: self.continueGameObject!)
        }
    }
    
    @IBAction func flashButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCat", sender: self)
    }
    
    @IBAction func contButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toYesNoGame", sender: self)
    }
    
    
    func checkProgress() {
        let (inProgress, wordList, score, mainType, mainID, currIndex, correctIDs, wrongIDs) = UserDatabaseUtility.getGameProgress()
        if inProgress {
            contButton.isHidden = false
            self.yesNoGameObject = YesNoGameObject(mainID: mainID, mainType: mainType)
            self.continueGameObject = ContinueGameHelperObject(wordListID: wordList, score: score, currIndex: currIndex, correctIDs: correctIDs, wrongIDs: wrongIDs)
        } else {
            contButton.isHidden = true
        }
    }
    
    func initilaizeDatabases() {
        guard let dbPath = Bundle.main.path(forResource: "GreSynonymsDatabase", ofType: "sqlite3") else {
            fatalError("Could not locate Diciontary database!")
        }
        do {
            let dictionaryDatabase = try Connection(dbPath)
            DictionaryDatabaseUtility.database = dictionaryDatabase
        } catch {
            print(error)
            fatalError("Could not connect to dictioanry database!")
        }
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("userDatabase").appendingPathExtension("sqlite3")
            let userDatabase = try Connection(fileUrl.path)
            print(fileUrl.path)
            UserDatabaseUtility.database = userDatabase
        } catch {
            print(error)
            fatalError("Failed user database creation and connection")
        }
        UserDatabaseUtility.createUserTables()
    }

}

