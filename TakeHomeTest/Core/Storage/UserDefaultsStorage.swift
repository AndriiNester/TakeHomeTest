//
//  UserDefaultsStorage.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class UserDefaultsStorage: Storage {

    private let userDefaults = UserDefaults.standard

    private static let locationsKey = "locations"

    func object<T: StorageObject>(withId id: String) -> T? {
        guard let locationJson = locationsDictionary[id] as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: locationJson)
    }

    func allObjects<T: StorageObject>() -> [T] {
        let decoder = JSONDecoder()
        return locationsDictionary.map { element -> T? in
            let (_, value) = element
            guard let data = value as? Data else {
                return nil
            }
            return try? decoder.decode(T.self, from: data)
            }.compactMap { $0 }
    }

    func create<T: StorageObject>(_ entity: T) {
        guard let encoded = try? JSONEncoder().encode(entity) else {
            return
        }
        var locations = locationsDictionary
        locations[entity.storageId] = encoded
        userDefaults.set(locations, forKey: UserDefaultsStorage.locationsKey)
    }

    func update<T: StorageObject>(_ entity: T) {
        guard locationsDictionary[entity.storageId] != nil else {
            return
        }
        // overriding the entity
        create(entity)
    }

    private var locationsDictionary: [String: Any] {
        return userDefaults.object(forKey: UserDefaultsStorage.locationsKey) as? [String: Any] ?? [:]
    }
}
