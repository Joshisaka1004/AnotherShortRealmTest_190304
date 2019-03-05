//
//  PuzzleFamilies.swift
//  AnotherShortRealmTest_190304
//
//  Created by Joachim Vetter on 04.03.19.
//  Copyright © 2019 Joachim Vetter. All rights reserved.
//

import Foundation
import RealmSwift

class PuzzleFamilies: Object {
    @objc dynamic var puzzleNames: String = ""
    @objc dynamic var id = UUID().uuidString
    let children = List<SpecialPuzzle>()
    
    override static func primaryKey() -> String {
        return "id"
    }
}
