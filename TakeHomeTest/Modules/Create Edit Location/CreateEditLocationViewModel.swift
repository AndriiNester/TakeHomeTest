//
//  CreateEditLocationViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import CoreLocation

class CreateEditLocationViewModel {

    private(set) var location: ScenicPhotoLocation?

    var name: String?
    var notes: String?
    let coordinate: CLLocationCoordinate2D

    var isSaveEnabled: Bool {
        return name != nil && name?.isEmpty == false
    }

    var screenTitle: String {
        if location == nil {
            return NSLocalizedString("New Location", comment: "Title for screen when creating location")
        } else {
            return NSLocalizedString("Edit Location", comment: "Title for screen when editing location")
        }
    }

    private let storage: Storage

    init(location: ScenicPhotoLocation, storage: Storage = UserDefaultsStorage()) {
        self.location = location
        self.storage = storage
        self.name = location.name
        self.notes = location.notes
        self.coordinate = location.coordinate
    }

    init(coordinate: CLLocationCoordinate2D, storage: Storage = UserDefaultsStorage()) {
        self.coordinate = coordinate
        self.storage = storage
    }

    func saveLocation() {
        if location != nil {
            saveLocation(withMethod: storage.update)
        } else {
            saveLocation(withMethod: storage.create)
        }
    }

    // MARK: - Private

    private func saveLocation(withMethod storageMethod: ((ScenicPhotoLocation) -> Void)) {
        guard let name = name else {
            return
        }
        let newLocation = ScenicPhotoLocation(name: name,
                                              latitude: coordinate.latitude,
                                              longitude: coordinate.longitude,
                                              notes: notes)
        storageMethod(newLocation)
        location = newLocation
    }

}
