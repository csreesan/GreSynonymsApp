//
//  MainViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit
import SQLite


class MainViewController: UIViewController {
    
    
    @IBOutlet weak var contButton: UIButton!
    var yesNoGameObject: YesNoGameObject?
    var continueGameObject: ContinueGameHelperObject?
    var sendingSegue: String = ""
    var sendingLabel: String = ""
    
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
        self.sendingSegue = Constants.toYesNoGameSegue
        self.sendingLabel = Constants.categoryToTestLabel
        performSegue(withIdentifier: Constants.toCategoryControllerSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toCategoryControllerSegue {
            let categoryList: [FlashCardCategory]
            let tableType: TableType
            if self.sendingLabel == Constants.allWordsLabel {
                categoryList = DictionaryDatabaseUtility.getAllWords()
                tableType = .words
            } else {
                categoryList = DictionaryDatabaseUtility.getAllSynonymObjects()!
                tableType = .synonyms
            }
            let destinationVC = segue.destination as! CateogriesViewController
            destinationVC.prepareCategoryController(categoryList: categoryList, segueID: self.sendingSegue, label: self.sendingLabel, pickerObject: PickerObject(type: tableType))
        }
        if segue.identifier == Constants.toYesNoGameSegue {
            let destinationVC = segue.destination as! YesNoGameViewController
            destinationVC.continueGameOverride(gameObject: self.yesNoGameObject!, continueObject: self.continueGameObject!)
        }
    }
    
    @IBAction func flashButtonPushed(_ sender: UIButton) {
        self.sendingSegue = Constants.toWordsSegue
        self.sendingLabel = Constants.flashCardsMainLabel
        performSegue(withIdentifier: Constants.toCategoryControllerSegue, sender: self)
    }
    
    @IBAction func contButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.toYesNoGameSegue, sender: self)
    }
    
    @IBAction func allWordsButtonPressed(_ sender: UIButton) {
        self.sendingSegue = Constants.toFlashSegue
        self.sendingLabel = Constants.allWordsLabel
        performSegue(withIdentifier: Constants.toCategoryControllerSegue, sender: self)
    }
    
    @IBAction func howToButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.toHowToSegue, sender: self)
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

