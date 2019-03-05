//
//  DetailVC.swift
//  AnotherShortRealmTest_190304
//
//  Created by Joachim Vetter on 04.03.19.
//  Copyright © 2019 Joachim Vetter. All rights reserved.
//

import UIKit
import RealmSwift

class DetailVC: UITableViewController {

    var detailResults: Results<SpecialPuzzle>?
    var selectedCategory: PuzzleFamilies?
    var temporary: [String]?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedCategory ?? "nope")
        loadIt()
        titleNavBar()
    }
    
    func titleNavBar() {
        title = selectedCategory?.puzzleNames ?? "No Name available"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = selectedCategory {
            return item.children.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if let item = selectedCategory {
            myCell.textLabel?.text = item.children[indexPath.row].specialPuzzleNames
        }
        
        return myCell
    }

    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        var finalTextField = UITextField()
        
        let myAlertVC = UIAlertController(title: "Add your puzzle favourite!", message: "", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            if let currentParent = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newPuzzle = SpecialPuzzle()
                        newPuzzle.specialPuzzleNames = finalTextField.text!
                        currentParent.children.append(newPuzzle)
                        self.loadIt()
                    }
                }
                catch {
                    print("\(error)")
                }
                
            }
            
        }
        
        myAlertVC.addAction(myAction)
        myAlertVC.addTextField { (myTextField) in
            finalTextField = myTextField
        }
        present(myAlertVC, animated: true, completion: nil)
    }

    func saveIt(realm: Realm = try! Realm(), obj: SpecialPuzzle) {
        do {
            try realm.write {
                realm.add(obj)
            }
        }
        catch {
            print("\(error)")
        }
    }
    
    func loadIt(realm: Realm = try! Realm()) {
        
        detailResults = realm.objects(SpecialPuzzle.self).sorted(byKeyPath: "specialPuzzleNames")
        tableView.reloadData()
    }
    
}
