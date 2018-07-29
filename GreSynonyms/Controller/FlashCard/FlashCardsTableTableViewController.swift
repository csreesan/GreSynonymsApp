//
//  FlashCardsTableTableViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/18/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import UIKit

protocol WordListAndIndexReceiver {
    func receivedWordListAndIndex(wordList: [WordObject], index: Int)
}

class FlashCardsTableTableViewController: UITableViewController, WordListReceiver {

    var wordList: [WordObject] = []
    var indexSelected: Int = 0
    var synonymId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = wordList[indexPath.row].word
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toFlashSegue {
            let destinationVC = segue.destination as! WordsTabBarController
            destinationVC.receivedWordListAndIndex(wordList: self.wordList, index: self.indexSelected)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = indexPath.row
        performSegue(withIdentifier: Constants.toFlashSegue, sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func receivedWordList(wordList: [WordObject]) {
        self.wordList = wordList
    }
}
