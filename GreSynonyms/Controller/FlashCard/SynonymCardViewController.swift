//
//  SynonymCardViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class SynonymCardViewController: UIViewController {

    @IBOutlet weak var synonymsLabel: UILabel!
    var synonymsList = [WordObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        let stringList = self.synonymsList.map {$0.word}
        self.synonymsLabel.text = stringList.joined(separator: "\n")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSynonymsList(synonymsList: [WordObject]) {
        self.synonymsList = synonymsList
    }
}
