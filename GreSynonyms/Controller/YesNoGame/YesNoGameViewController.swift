//
//  YesNoGameViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/4/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class YesNoGameViewController: UIViewController {
    
    //MARK: Instance Attributes
    var categories: [String] = []
    var score = 0
    var currWordIndex = 0
    var totalWords = 0
    var wordList = [WordObject]()
    var wordListEncoded: String = ""
    var gameObject: YesNoGameObject?
    var prevViewController: UIViewController?
    var correctWordList: [WordObject] = []
    var wrongWordList: [WordObject] = []
    var answerKey: [Int] = []
    
    @IBOutlet weak var yepButton: UIButton!
    @IBOutlet weak var nopeButton: UIButton!
    @IBOutlet weak var mainWordLabel: UILabel!
    @IBOutlet weak var changingWordLabel: UILabel!
    
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSetup()
        self.navigationController?.isNavigationBarHidden = true
        self.nopeButton.layer.cornerRadius = 20
        self.yepButton.layer.cornerRadius = 20
        updateScoreAndProgress()
        storeProgressToDatabse()
    }
    
    func gameSetup() {
        self.mainWordLabel.text = self.gameObject?.mainLabel
        self.changingWordLabel.text = self.wordList[self.currWordIndex].word
        self.totalWords = self.wordList.count
        self.wordListEncoded = (self.wordList.map {String($0.id)}).joined(separator: ",")
        self.answerKey = self.gameObject!.answerKey
    }
    
    func receivedGameObject(gameObject: YesNoGameObject) {
        self.gameObject = gameObject
        self.wordList = (self.gameObject?.shuffledWordList)!
    }
    
    func continueGameOverride(gameObject: YesNoGameObject, continueObject: ContinueGameHelperObject) {
        self.gameObject = gameObject
        self.wordList = continueObject.wordList
        self.correctWordList = continueObject.correctWords
        self.currWordIndex = continueObject.currIndex
        self.score = continueObject.score
        self.wrongWordList = continueObject.wrongWords
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkAnswer(answerTag: Int) {
        let result: Int
        let currentWordObject = self.wordList[self.currWordIndex]
        let synListIDForLog: [Int]
        if answerTag == correctButtonTag() {
            ProgressHUD.showSuccess("Correct!")
            self.score += 1
            self.correctWordList.append(currentWordObject)
            result = 1
            synListIDForLog = currentWordObject.getSynonymIDList().filter {self.answerKey.contains($0)}
        } else {
            ProgressHUD.showError("Wrong!")
            self.wrongWordList.append(currentWordObject)
            result = 0
            synListIDForLog = self.answerKey
        }
        for synID in synListIDForLog {
            UserDatabaseUtility.insertToAttempts(timeStamp: Date(), synonymID: synID, wordID: currentWordObject.id, result: result)
        }
    }
    
    func correctButtonTag() -> Int{
        let currWordSynID = self.wordList[self.currWordIndex].getSynonymIDList()
        for id in currWordSynID {
            if self.answerKey.contains(id) {
                return 1
            }
        }
        return 0
    }
    
    
    func updateScoreAndProgress() {
        self.progressBarWidthConstraint.constant = (view.frame.size.width / CGFloat(totalWords)) * CGFloat(self.currWordIndex + 1)
        let wordNumDisp = (self.currWordIndex + 1 <= self.totalWords) ? self.currWordIndex + 1 : self.totalWords
        self.scoreLabel.text = "Score: \(score)"
        self.progressLabel.text = "\(wordNumDisp) out of \(totalWords)"
    }
    
    func nextWord() {
        self.currWordIndex += 1
        updateScoreAndProgress()
        if self.currWordIndex < self.totalWords {
            self.changingWordLabel.text = self.wordList[self.currWordIndex].word
            storeProgressToDatabse()
        } else {
            storeProgressToDatabse(endGame: true)
            insertToCompletedGamesTable()
            let alert = UIAlertController(title: "Done!", message: "You've finished all the words, with the score of \(score)/\(totalWords)!", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Main Menu", style: .default, handler: {(UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            })
            let flashCardAction = UIAlertAction(title: "To Game Flash Cards", style: .default, handler: {(UIAlertAction) in
                self.goToCategoriesViewController()
            })
            alert.addAction(restartAction)
            alert.addAction(flashCardAction)
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func answerSelected(_ sender: UIButton) {
        checkAnswer(answerTag: sender.tag)
        nextWord()
    }
    
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func endButtonPressed(_ sender: Any) {
        storeProgressToDatabse(endGame: true)
        self.goToCategoriesViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toCategoryControllerSegue {
            let synList = self.gameObject!.synonymObjectList
            for syn in synList {
                syn.stat = String(syn.getWords().count)
            }
            var categoryList : [FlashCardCategory] = synList
            let allChallenges: ArraySlice<WordObject> = self.wordList[..<self.currWordIndex]
            categoryList.append(SpecialCateogryObject(type: .yourChallenges, wordList: Array(allChallenges)))
            categoryList.append(SpecialCateogryObject(type: .yourHits, wordList: self.correctWordList))
            categoryList.append(SpecialCateogryObject(type: .yourMisses, wordList: self.wrongWordList))
            let destinationVC = segue.destination as! CateogriesViewController
            destinationVC.prepareCategoryController(categoryList: categoryList, segueID: Constants.toWordsSegue, label: Constants.endOfGameLabel, pickerObject: PickerObject(type: .endOfGame))
        }
    }
    
    func storeProgressToDatabse(endGame: Bool=false) {
        if endGame {
            UserDatabaseUtility.updateContinue(inProgress: 0, wordList: "", score: 0, mainType: "", mainID: 0, currIndex: 0, correctIDs: "", wrongIDs: "")
            return
        }
        let mainType = self.gameObject!.gameObjectType.rawValue
        let mainID = self.gameObject!.mainID
        let rightIDs = (self.correctWordList.map{String($0.id)}).joined(separator: ",")
        let wrongIDs = (self.wrongWordList.map{String($0.id)}).joined(separator: ",")
        UserDatabaseUtility.updateContinue(inProgress: 1, wordList: self.wordListEncoded, score: self.score, mainType: mainType, mainID: mainID, currIndex: self.currWordIndex, correctIDs: rightIDs, wrongIDs: wrongIDs)
    }
    
    func goToCategoriesViewController() {
        performSegue(withIdentifier: Constants.toCategoryControllerSegue, sender: self)
    }
    
    func insertToCompletedGamesTable() {
        let answerKeySet = Set(self.answerKey)
        let trickWords = self.wordList.filter {(Set($0.getSynonymIDList()).intersection(answerKeySet)).count <= 0}
        let correcIdSet = Set(self.correctWordList.map {$0.id})
        let trickWordsIdSet = Set(trickWords.map {$0.id})
        let trueNegativeCount = (correcIdSet.intersection(trickWordsIdSet)).count
        for synID in self.answerKey {
            let allPositiveCount = (self.wordList.filter {$0.getSynonymIDList().contains(synID)}).count
            let truePositiveCount = (self.correctWordList.filter {$0.getSynonymIDList().contains(synID)}).count
            let totalNum = allPositiveCount + trickWords.count
            let correctNum = trueNegativeCount + truePositiveCount
            UserDatabaseUtility.insertToCompletedGames(timeStamp: Date(), synonymID: synID, correctNum: correctNum, totalNum: totalNum)
        }
    }
    
}
