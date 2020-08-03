//
//  Item.swift
//  ToDoList
//
//  Created by MacOS on 7/31/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
