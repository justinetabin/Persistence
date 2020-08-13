//
//  RealmStore.swift
//  Persistence
//
//  Created by Justine Tabin on 8/11/20.
//  Copyright © 2020 Justine Tabin. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmStore<T: Object> {
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func insert(toInsert object: T, callback: @escaping (T?, Error?) -> Void) {
        do {
            try realm.write {
                realm.add(object, update: .all)
                callback(object, nil)
            }
        } catch let error {
            print(error)
            callback(nil, error)
        }
    }
    
    public func update(toUpdate object: T, callback: @escaping (T?, Error?) -> Void) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
                callback(object, nil)
            }
        } catch let error {
            callback(nil, error)
        }
    }
    
    public func delete(toDelete object: T, callback: @escaping (T?, Error?) -> Void) {
        do {
            try realm.write {
                realm.delete(object)
                callback(object, nil)
            }
        } catch let error {
            callback(nil, error)
        }
    }
    
    public func get(primaryKey: Any, callback: @escaping (T?, Error?) -> Void) {
        let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey)
        callback(object, nil)
    }
    
    public func list(callback: (Results<T>?, Error?) -> Void) {
        let objects = realm.objects(T.self)
        callback(objects, nil)
    }
    
    public func deleteAll(callback: @escaping (Error?) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                callback(nil)
            }
        } catch let error {
            callback(error)
        }
    }
}

