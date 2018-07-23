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
    
    var meaningObjectList: [MeaningObject]? = nil
    var wordObject: WordObject? = nil
    var synonymViewController: SynonymCardViewController? = nil
    var meaningIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wordLabel.text = wordObject!.word
        self.meaningObjectList = self.wordObject?.getMeaningList()
        updateUI()
    }
    
    func updateUI() {
        let meaningObject = self.meaningObjectList![self.meaningIndex]
        partOfSpeechLabel.text = meaningObject.partOfSpeech
        meaningLabel.text = meaningObject.meaning
        exampleLabel.text =  "\"\(meaningObject.example)\""
        if meaningIndex <= 0 {
            self.prevButton.isHidden = true
        } else {
            self.prevButton.isHidden = false
        }
        if meaningIndex >= (meaningObjectList?.count)! - 1 {
            self.nextButton.isHidden = true
        } else {
            self.nextButton.isHidden = false
        }
        self.synonymViewController?.setSynonymsList(synonymsList: meaningObject.getSynonyms())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setWordObjectAndSynonymVC(wordObject: WordObject, synonymVC: SynonymCardViewController) {
        self.wordObject = wordObject
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toYesNoGameSeagueIdentifier {
            let gameVC = segue.destination as! YesNoGameViewController
            gameVC.receivedGameObject(gameObject: YesNoGameObject(wordObject: self.wordObject!))
        }
    }
    
    @IBAction func testButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toYesNoGame", sender: self)
    }
    
    
    
}
