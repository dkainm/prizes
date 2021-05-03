//
//  Prize.swift
//  prizes
//
//  Created by Alex Rudoi on 2/5/21.
//

import RealmSwift

class Prize: Object {
    @objc dynamic var name = ""
    @objc dynamic var price = 0
    
    convenience init(name: String, price: Int) {
        self.init()
        self.name = name
        self.price = price
    }
}
