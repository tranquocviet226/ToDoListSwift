//
//  Category.swift
//  ToDoList
//
//  Created by MacOS on 8/4/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
