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
    
    var wordObject: WordObject = WordObject(id: 0, word: "", partOfSpeech: "", meaning: "", example: "", synonymId: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = wordObject.word
        partOfSpeechLabel.text = wordObject.partOfSpeech
        meaningLabel.text = wordObject.meaning
        exampleLabel.text = wordObject.example
        wordLabel.sizeToFit()
        meaningLabel.sizeToFit()
        exampleLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setWordObject(wordObject: WordObject) {
        self.wordObject = wordObject
    }
}
