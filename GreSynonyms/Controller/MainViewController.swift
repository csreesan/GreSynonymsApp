//
//  MainViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func newGameButtonPushed(_ sender: Any) {
//        performSegue(withIdentifier: "toSelectCategories", sender: self)
//    }
    
    @IBAction func buttonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "toSelectCategories", sender: self)
    }
}

