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
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var prevWordButton: UIButton!
    @IBOutlet weak var nextWordButton: UIButton!
    
    var synonymViewController: SynonymCardViewController? = nil
    var meaningIndex = 0
    
    var wordList:[WordObject]  = []
    var wordIndex = 0
    
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
        if meaningIndex <= 0 {
            self.prevButton.isHidden = true
        } else {
            self.prevButton.isHidden = false
        }
        if meaningIndex >= (meaningObjectList.count) - 1 {
            self.nextButton.isHidden = true
        } else {
            self.nextButton.isHidden = false
        }
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
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.meaningIndex += 1
        updateUI()
    }
    
    @IBAction func preButtonPressed(_ sender: UIButton) {
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
            gameVC.receivedGameObject(gameObject: YesNoGameObject(wordObject: self.wordList[self.wordIndex]))
        }
    }
    
    @IBAction func testButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toYesNoGame", sender: self)
    }
    
    
    
}
