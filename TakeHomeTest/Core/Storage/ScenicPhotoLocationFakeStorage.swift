//
//  ScenicPhotoLocationFakeStorage.swift
//  TakeHomeTest
//
//  Created by Andrew Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class ScenicPhotoLocationFakeStorage: ScenicPhotoLocationStorage {

    var returnedLocationById: ScenicPhotoLocation?
    var returnedAllLocations: [ScenicPhotoLocation] = []
    var isGetLocationWithIdCalled = false
    var isGetAllLocationsCalled = false
    var isCreateLocationCalled = false
    var isUpdateLocationCalled = false

    func getLocation(withId id: String) -> ScenicPhotoLocation? {
        isGetLocationWithIdCalled = true
        return returnedLocationById
    }

    func getAllLocations() -> [ScenicPhotoLocation] {
        isGetAllLocationsCalled = true
        return returnedAllLocations
    }

    func createLocation(_ location: ScenicPhotoLocation) {
        isCreateLocationCalled = true
    }

    func updateLocation(_ location: ScenicPhotoLocation) {
        isUpdateLocationCalled = true
    }

}
