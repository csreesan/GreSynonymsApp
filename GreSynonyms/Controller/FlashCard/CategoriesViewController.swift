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
class CateogriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategoryObjectListReceiver {
    
    
    @IBOutlet weak var categoryTableView: UITableView!
    var categories: [FlashCardCategory] = []
    var chosenIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
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
        performSegue(withIdentifier: "toWords", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWords" {
            let destinationVC = segue.destination as! FlashCardsTableTableViewController
            destinationVC.receivedWordList(wordList: categories[self.chosenIndex].getWords())
        }
    }
    
    func receivedCategoryObjectList(categoryList: [FlashCardCategory]) {
        self.categories = categoryList
    }
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
