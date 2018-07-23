//
//  MainViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit
import SQLite

protocol CategoryObjectListReceiver {
    func receivedCategoryObjectList(categoryList: [FlashCardCategory])
}

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        guard let dbPath = Bundle.main.path(forResource: "GreSynonymsDatabase", ofType: "sqlite3") else {
            fatalError("Could not locate database!")
        }
        do {
            let database = try Connection(dbPath)
            DatabaseUtility.database = database
        } catch {
            print(error)
            fatalError("Could not connect to database!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func yeahNahButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "toYesNoCateogrySelection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCat" {
            var categoryList : [FlashCardCategory] = [AllWordsCategoryObject()]
            categoryList.append(contentsOf: DatabaseUtility.getAllSynonymObjects()!)
            let destinationVC = segue.destination as! CateogriesViewController
            destinationVC.receivedCategoryObjectList(categoryList: categoryList)
        }
    }
    
    @IBAction func flashButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCat", sender: self)
    }
    
}

