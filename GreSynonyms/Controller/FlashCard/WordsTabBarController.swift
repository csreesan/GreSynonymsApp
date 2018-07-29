//
//  WordsTabBarController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class WordsTabBarController: UITabBarController, WordListAndIndexReceiver {

    var wordList: [WordObject] = []
    var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let wordMeaningVC = self.viewControllers![0] as! WordMeaningViewController
        let synonymVC = self.viewControllers![1] as! SynonymCardViewController
        wordMeaningVC.setWordListAndIndexAndVC(wordList: self.wordList, index: index, synonymVC: synonymVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receivedWordListAndIndex(wordList: [WordObject], index: Int) {
        self.wordList = wordList
        self.index = index
    }
}
