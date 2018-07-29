//
//  HowToViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/29/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var explanationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setUI(section: .basics)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func basicsButtonPressed(_ sender: UIButton) {
        setUI(section: .basics)
    }
    
    @IBAction func testingButtonPressed(_ sender: Any) {
        setUI(section: .testing)
    }
    
    
    @IBAction func useStatsButtonPressed(_ sender: UIButton) {
        setUI(section: .useStats)
    }
    
    @IBAction func flashcardsButtonPressed(_ sender: UIButton) {
        setUI(section: .flashcards)
    }
    
    func setUI(section: HowToSection) {
        mainLabel.text = section.label()
        explanationLabel.text = section.explanation()
    }
    

}
