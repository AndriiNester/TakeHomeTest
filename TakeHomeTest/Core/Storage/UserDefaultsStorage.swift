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

    func get<T: StorageObject>(byId id: String) -> T? {
        let locationsEncoded = userDefaults.object(forKey: UserDefaultsStorage.locationsKey) as? [String: Any] ?? [:]
        let decoder = JSONDecoder()
        guard let locationJson = locationsEncoded[id] as? Data else {
            return nil
        }
        return try? decoder.decode(T.self, from: locationJson)
    }

    func getAll<T: StorageObject>() -> [T] {
        let locationsEncoded = userDefaults.object(forKey: UserDefaultsStorage.locationsKey) as? [String: Any] ?? [:]
        let decoder = JSONDecoder()
        let locations = locationsEncoded.map { element -> T? in
            let (_, value) = element
            guard let data = value as? Data else {
                return nil
            }
            return try? decoder.decode(T.self, from: data)
            }.compactMap { $0 }
        return locations
    }

    func create<T: StorageObject>(_ entity: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(entity) {
            var locations = locationsDictionary
            locations[entity.storageId] = encoded
            userDefaults.set(locations, forKey: UserDefaultsStorage.locationsKey)
        }
    }

    func update<T: StorageObject>(_ entity: T) {
        if locationsDictionary[entity.storageId] != nil {
            // overriding the entity
            create(entity)
        }
    }

    private var locationsDictionary: [String: Any] {
        return userDefaults.object(forKey: UserDefaultsStorage.locationsKey) as? [String: Any] ?? [:]
    }
}
