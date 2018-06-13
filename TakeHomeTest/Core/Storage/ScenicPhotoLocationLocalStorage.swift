//
//  ScenicPhotoLocationManager.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

protocol ScenicPhotoLocationStorage {
    func getLocation(withId id: String) -> ScenicPhotoLocation?
    func getAllLocations() -> [ScenicPhotoLocation]
    func createLocation(_ location: ScenicPhotoLocation)
    func updateLocation(_ location: ScenicPhotoLocation)
}

class ScenicPhotoLocationLocalStorage: ScenicPhotoLocationStorage {

    private let storage: Storage

    init(storage: Storage = UserDefaultsStorage()) {
        self.storage = storage
    }

    func getLocation(withId id: String) -> ScenicPhotoLocation? {
        return storage.get(byId: id)
    }

    func getAllLocations() -> [ScenicPhotoLocation] {
        return storage.getAll()
    }

    func createLocation(_ location: ScenicPhotoLocation) {
        storage.create(location)
    }

    func updateLocation(_ location: ScenicPhotoLocation) {
        storage.update(location)
    }

}
