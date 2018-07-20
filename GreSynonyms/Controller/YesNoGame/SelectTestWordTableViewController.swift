//
//  SelectTestWordTableViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 6/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

protocol YesNoGameObjectReceiver {
    func receivedGameObjectAndCurrentVC(gameObject: YesNoGameObject, viewController: UIViewController)
}

let toYesNoGameSeagueIdentifier = "toYesNoGame"

class SelectTestWordTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var wordsTableView: UITableView!
    @IBOutlet weak var orderingPickerView: UIPickerView!
    let wordList = DatabaseUtility.getAllWords()
    var wordIndex = 0
    var checkMarkCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wordsTableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.wordList[indexPath.row].word
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.wordIndex = indexPath.row
        performSegue(withIdentifier: toYesNoGameSeagueIdentifier, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toYesNoGameSeagueIdentifier {
            let gameVC = segue.destination as! YesNoGameViewController
            gameVC.receivedGameObjectAndCurrentVC(gameObject: YesNoGameObject(chosenWordObject: self.wordList[self.wordIndex]), viewController: self)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
