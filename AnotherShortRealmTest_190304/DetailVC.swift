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

    var testVar: String?
    var selectedCategory: PuzzleFamilies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedCategory ?? "nope")
        titleNavBar()
    }
    
    func titleNavBar() {
        title = selectedCategory?.puzzleNames ?? "No Name available"
    }
    
    

    @IBAction func addBtn(_ sender: UIBarButtonItem) {
    }
    
}
