//
//  WordsTabBarController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class WordsTabBarController: UITabBarController, WordObjectReceiver {

    var wordObject: WordObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        let wordMeaningVC = self.viewControllers![0] as! WordMeaningViewController
        let synonymVC = self.viewControllers![1] as! SynonymCardViewController
        wordMeaningVC.setWordObjectAndSynonymVC(wordObject: wordObject!, synonymVC: synonymVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receivedWordObject(wordObject: WordObject) {
        self.wordObject = wordObject
    }

}
