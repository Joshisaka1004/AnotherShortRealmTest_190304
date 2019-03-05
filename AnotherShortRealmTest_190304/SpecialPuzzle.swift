//
//  SpecialPuzzle.swift
//  AnotherShortRealmTest_190304
//
//  Created by Joachim Vetter on 04.03.19.
//  Copyright © 2019 Joachim Vetter. All rights reserved.
//

import Foundation
import RealmSwift

class SpecialPuzzle: Object {
    @objc dynamic var specialPuzzleNames: String = ""
    @objc dynamic var specialPuzzleLevel: String = ""
    let parent = LinkingObjects(fromType: PuzzleFamilies.self, property: "children")
}
