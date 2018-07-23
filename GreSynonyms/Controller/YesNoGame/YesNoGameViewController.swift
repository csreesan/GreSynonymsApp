//
//  YesNoGameViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/4/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class YesNoGameViewController: UIViewController, YesNoGameObjectReceiver {
    
    //MARK: Instance Attributes
    var categories: [String] = []
    var score = 0
    var currWord = 0
    var totalWords = 0
    var wordList = [WordObject]()
    var gameObject: YesNoGameObject?
    var prevViewController: UIViewController?
    var correctWordList: [WordObject] = []
    var wrongWordList: [WordObject] = []
    var correctIDs: [Int] = []
    
    @IBOutlet weak var yepButton: UIButton!
    @IBOutlet weak var nopeButton: UIButton!
    @IBOutlet weak var mainWordLabel: UILabel!
    @IBOutlet weak var changingWordLabel: UILabel!
    
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wordList = (self.gameObject?.shuffledWordList)!
        self.mainWordLabel.text = self.gameObject?.mainLabel
        self.changingWordLabel.text = self.wordList[self.currWord].word
        self.totalWords = self.wordList.count
        self.navigationController?.isNavigationBarHidden = true
        self.nopeButton.layer.cornerRadius = 20
        self.yepButton.layer.cornerRadius = 20
        updateScoreAndProgress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func receivedGameObject(gameObject: YesNoGameObject) {
        self.gameObject = gameObject
        self.correctIDs = gameObject.correctIDs
    }
    
    func checkAnswer(answerTag: Int) {
        if answerTag == correctButtonTag() {
            ProgressHUD.showSuccess("Correct!")
            self.score += 1
            self.correctWordList.append(self.wordList[self.currWord])
        } else {
            ProgressHUD.showError("Wrong!")
            self.wrongWordList.append(self.wordList[self.currWord])
        }
    }
    
    func correctButtonTag() -> Int{
        let currWordSynID = self.wordList[self.currWord].getSynonymIDList()
        for id in currWordSynID {
            if self.correctIDs.contains(id) {
                return 1
            }
        }
        return 0
    }
    
    
    func updateScoreAndProgress() {
        self.progressBarWidthConstraint.constant = (view.frame.size.width / CGFloat(totalWords)) * CGFloat(self.currWord + 1)
        let wordNumDisp = (self.currWord + 1 <= self.totalWords) ? self.currWord + 1 : self.totalWords
        self.scoreLabel.text = "Score: \(score)"
        self.progressLabel.text = "\(wordNumDisp) out of \(totalWords)"
    }
    
    func nextWord() {
        self.currWord += 1
        updateScoreAndProgress()
        if self.currWord < self.totalWords {
            self.changingWordLabel.text = self.wordList[self.currWord].word
        } else {
            let alert = UIAlertController(title: "Done!", message: "You've finished all the words, with the score of \(score)!", preferredStyle: .alert)
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
        self.goToCategoriesViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCat" {
            var categoryList : [FlashCardCategory] = self.gameObject!.synonymObjectList
            categoryList.append(SpecialCateogryObject(isCorrect: true, wordList: self.correctWordList))
            categoryList.append(SpecialCateogryObject(isCorrect: false, wordList: self.wrongWordList))
            let destinationVC = segue.destination as! CateogriesViewController
            destinationVC.receivedCategoryObjectList(categoryList: categoryList)
        }
    }
    
    func goToCategoriesViewController() {
        performSegue(withIdentifier: "toCat", sender: self)
    }
    
}
