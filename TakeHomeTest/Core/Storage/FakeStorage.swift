//
//  FakeStorage.swift
//  TakeHomeTest
//
//  Created by Andrew Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class FakeStorage: Storage {

    var returnedObjectWithId: StorageObject?
    var returnedAll: [StorageObject] = []
    var isObjectWithIdCalled = false
    var isAllObjectsCalled = false
    var isCreateCalled = false
    var isUpdateCalled = false

    func object<T>(withId id: String) -> T? where T : StorageObject {
        isObjectWithIdCalled = true
        return returnedObjectWithId as? T
    }

    func allObjects<T>() -> [T] where T : StorageObject {
        isAllObjectsCalled = true
        return returnedAll as! [T]
    }

    func create<T>(_ entity: T) where T : StorageObject {
        isCreateCalled = true
    }

    func update<T>(_ entity: T) where T : StorageObject {
        isUpdateCalled = true
    }

}
