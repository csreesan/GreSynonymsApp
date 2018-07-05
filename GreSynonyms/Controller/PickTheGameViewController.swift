//
//  PickTheGameViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/4/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class PickTheCategoryGameViewController: UIViewController, SelectCategoriesDelegate {
    
    //MARK: Instance Attributes
    var categories: [String] = []
    var score = 0
    var wordList: [WordClass] = []
    var synonymsDict: [String:[WordClass]] = ["":[]]
    var wordNum = 1
    var totalWords = 0
    var buttonsArray: [UIButton?] = []
    
    // MARK: UI Properties
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!

    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        hideAllButtons()
        super.viewDidLoad()
        wordLabel.text = wordList[wordNum - 1].getWord()
        let buttonsArray = [button0, button1, button2, button3, button4, button5]
        if !categories.isEmpty {
            for (i, category) in categories.enumerated() {
                let button = buttonsArray[i]!
                button.isHidden = false
                button.setTitle(category, for: .normal)
                button.layer.cornerRadius = 10
            }
        }
        self.buttonsArray = buttonsArray
        updateScoreAndProgress()
    }
    
    func hideAllButtons() {
        button0.isHidden = true
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        button5.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func categoriesSelected(categories: [String], synonymsDict: [String: [WordClass]]) {
        let pickTheCategoryModel = PickTheCategoryModel(chosenCategories: categories, synonymsDict: synonymsDict)
        self.categories = categories
        self.wordList = pickTheCategoryModel.wordList
        self.totalWords = self.wordList.count
        self.synonymsDict = pickTheCategoryModel.synonymsDict
    }
    
    
    func checkAnswer(answer: String) {
        if answer == wordList[wordNum - 1].getAnswer() {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!\n Ans: " + wordList[wordNum - 1].getAnswer())
        }
    }
    
    func updateScoreAndProgress() {
        progressBarWidthConstraint.constant = (view.frame.size.width / CGFloat(totalWords)) * CGFloat(wordNum - 1)
        let wordNumDisp = (wordNum <= totalWords) ? wordNum : totalWords
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(wordNumDisp) out of \(totalWords)"
    }
    
    func nextWord() {
        wordNum += 1
        updateScoreAndProgress()
        if wordNum <= totalWords {
            wordLabel.text = wordList[wordNum - 1].getWord()
        } else {
            let alert = UIAlertController(title: "Done!", message: "You've finished all the words, with the score of \(score)!", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        let answer = self.buttonsArray[sender.tag]!.titleLabel?.text!
        checkAnswer(answer: answer!)
        nextWord()
    }
    
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "pickCategoryToMain", sender: self)
    }
}
