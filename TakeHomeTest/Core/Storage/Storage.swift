//
//  Storage.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

protocol StorageObject: Codable {
    var storageId: String { get }
}

protocol Storage {
    func object<T: StorageObject>(withId id: String) -> T?
    func allObjects<T: StorageObject>() -> [T]
    func create<T: StorageObject>(_ entity: T)
    func update<T: StorageObject>(_ entity: T)
}
