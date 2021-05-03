//
//  DatabaseManager.swift
//  prizes
//
//  Created by Alex Rudoi on 2/5/21.
//

import RealmSwift

class DatabaseManager {
    
    static var instance = DatabaseManager()
    
    let realm = try! Realm()
    
    func addPrize(_ prize: Prize) {
        try! realm.write {
            realm.add(prize)
        }
    }
    
    func deletePrize(_ prize: Prize) {
        try! realm.write {
            realm.delete(prize)
        }
    }
}
