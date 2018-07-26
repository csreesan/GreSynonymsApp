//
//  CategoriesViewController.swift
//  GreSynonyms
//
//  Created by Chris Sreesangkom on 7/20/18.
//  Copyright © 2018 Chris Sreesangkom. All rights reserved.
//

import Foundation

protocol WordListReceiver {
    func receivedWordList(wordList: [WordObject])
}
class CateogriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var mainLabel: UILabel!

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var orderPickerView: UIPickerView!
    var labelText = ""
    var segueID: String = ""
    var categories: [FlashCardCategory] = []
    var chosenIndex: Int = 0
    var pickerObject: PickerObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        orderPickerView.dataSource = self
        orderPickerView.delegate = self
        self.mainLabel.text = self.labelText
        if self.pickerObject!.type == .endOfGame {
            self.orderPickerView.isHidden = true
        } else {
            self.orderPickerView.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = categories[indexPath.row].getLabel()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chosenIndex = indexPath.row
        performSegue(withIdentifier: self.segueID, sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerObject!.labels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerObject!.labels[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toWordsSegue {
            let destinationVC = segue.destination as! FlashCardsTableTableViewController
            destinationVC.receivedWordList(wordList: categories[self.chosenIndex].getWords())
        }
        if segue.identifier == Constants.toYesNoGameSegue {
            let gameVC = segue.destination as! YesNoGameViewController
            gameVC.receivedGameObject(gameObject: YesNoGameObject(synonymObject: self.categories[self.chosenIndex] as! SynonymObject))
        }
        if segue.identifier == Constants.toFlashSegue {
            let destinationVC = segue.destination as! WordsTabBarController
            destinationVC.receivedWordObject(wordObject: self.categories[self.chosenIndex].getWords()[0])
        }
    }
    
    func prepareCategoryController(categoryList: [FlashCardCategory], segueID: String, label: String, pickerObject: PickerObject) {
        self.categories = categoryList
        self.segueID = segueID
        self.labelText = label
        self.pickerObject = pickerObject
    }
    
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
