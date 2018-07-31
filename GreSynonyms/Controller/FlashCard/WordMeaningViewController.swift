//
//  WordMeaningViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class WordMeaningViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    
    @IBOutlet weak var nextMeaningButton: UIButton!
    @IBOutlet weak var prevMeaningButton: UIButton!
    @IBOutlet weak var prevWordButton: UIButton!
    @IBOutlet weak var nextWordButton: UIButton!
    
    var synonymViewController: SynonymCardViewController? = nil
    var meaningIndex = 0
    
    var wordList:[WordObject]  = []
    var wordIndex = 0
    var actionSheetIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        updateUI()
    }
    
    func updateUI() {
        let wordObject = self.wordList[self.wordIndex]
        let meaningObjectList = wordObject.getMeaningList()
        let meaningObject = meaningObjectList[self.meaningIndex]
        partOfSpeechLabel.text = meaningObject.partOfSpeech
        self.wordLabel.text = wordObject.word
        meaningLabel.text = meaningObject.meaning
        exampleLabel.text =  "\"\(meaningObject.example)\""
        hideOrShowMeaningButtons(meaningObjectList: meaningObjectList)
        hideOrShowWordButtons()
        self.synonymViewController?.setSynonymsList(synonymsList: meaningObject.getSynonyms())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setWordListAndIndexAndVC(wordList: [WordObject], index: Int, synonymVC: SynonymCardViewController) {
        self.wordList = wordList
        self.wordIndex = index
        self.synonymViewController = synonymVC
    }
    
    
    func hideOrShowMeaningButtons(meaningObjectList: [MeaningObject]) {
        if meaningIndex <= 0 {
            self.prevMeaningButton.isHidden = true
        } else {
            self.prevMeaningButton.isHidden = false
        }
        if meaningIndex >= (meaningObjectList.count) - 1 {
            self.nextMeaningButton.isHidden = true
        } else {
            self.nextMeaningButton.isHidden = false
        }
    }
    
    func hideOrShowWordButtons() {
        if self.wordIndex <= 0 {
            self.prevWordButton.isHidden = true
        } else {
            self.prevWordButton.isHidden = false
        }
        if self.wordIndex >= self.wordList.count - 1 {
            self.nextWordButton.isHidden = true
        } else {
            self.nextWordButton.isHidden = false
        }
    }
    
    @IBAction func nextMeaningButtonPressed(_ sender: Any) {
        self.meaningIndex += 1
        updateUI()
    }
    @IBAction func prevMeaningButtonPressed(_ sender: Any) {
        self.meaningIndex -= 1
        updateUI()
    }

    
    @IBAction func prevWordButtonPressed(_ sender: Any) {
        self.wordIndex -= 1
        self.meaningIndex = 0
        updateUI()
    }
    
    @IBAction func nextWordButtonPressed(_ sender: Any) {
        self.wordIndex += 1
        self.meaningIndex = 0
        updateUI()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toYesNoGameSegue {
            let gameVC = segue.destination as! YesNoGameViewController
            if self.actionSheetIndex == 0 {
                gameVC.receivedGameObject(gameObject: YesNoGameObject(wordObject: self.wordList[self.wordIndex]))
            } else {
                let meaningObject = self.wordList[self.wordIndex].getMeaningList()[self.meaningIndex]
                let synonymObject = SynonymObject(id: meaningObject.synonymId)
                gameVC.receivedGameObject(gameObject: YesNoGameObject(synonymObject: synonymObject))
            }
        }
    }
    
    @IBAction func testButtonPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Your Test", message: nil, preferredStyle: .actionSheet)
        let testWord = UIAlertAction(title: "Test \"\(self.wordList[self.wordIndex].word)\"", style: .default, handler: {(UIAlertAction) in
            self.actionSheetIndex = 0
            self.performSegue(withIdentifier: "toYesNoGame", sender: self)
        })
        let meaningObject = self.wordList[self.wordIndex].getMeaningList()[self.meaningIndex]
        let synonymObject = SynonymObject(id: meaningObject.synonymId)
        let testSynonym = UIAlertAction(title: "Test \"\(synonymObject.label)\"", style: .default, handler: {(UIAlertAction) in
            self.actionSheetIndex = 1
            self.performSegue(withIdentifier: "toYesNoGame", sender: self)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        actionSheet.addAction(testWord)
        actionSheet.addAction(testSynonym)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    
}
