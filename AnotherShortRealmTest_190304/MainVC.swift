//
//  ViewController.swift
//  AnotherShortRealmTest_190304
//
//  Created by Joachim Vetter on 04.03.19.
//  Copyright © 2019 Joachim Vetter. All rights reserved.
//

import UIKit
import RealmSwift

class MainVC: UITableViewController {

    var myResults: Results<PuzzleFamilies>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        //deleteAllObjects()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myResults?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 22)
        myCell.textLabel?.text = myResults?[indexPath.row].puzzleNames ?? "Nothing yet!!!"
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationVC = segue.destination as! DetailVC
            if let myIndex = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = myResults?[myIndex.row]
            }
        }
    }

    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        var finalTextField = UITextField()
        
        let myAlertVC = UIAlertController(title: "Add your puzzle favourite!", message: "", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let newPuzzle = PuzzleFamilies()
            newPuzzle.puzzleNames = finalTextField.text!
            self.saveItems(myObject: newPuzzle)
            self.loadItems()
        }
        
        myAlertVC.addAction(myAction)
        myAlertVC.addTextField { (myTextField) in
            finalTextField = myTextField
        }
        present(myAlertVC, animated: true, completion: nil)
    }
    
    func saveItems(realm: Realm = try! Realm(), myObject: PuzzleFamilies) {
        do {
            try realm.write {
                realm.add(myObject)
            }
        }
        catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(realm: Realm = try! Realm()) {
        myResults = realm.objects(PuzzleFamilies.self)
        tableView.reloadData()
    }
    
    func deleteAllObjects(realm: Realm = try! Realm()) {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

