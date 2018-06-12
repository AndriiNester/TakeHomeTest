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

    private let localStorage = ScenicPhotoLocationLocalStorage()

    init(location: ScenicPhotoLocation) {
        self.location = location
        self.name = location.name
        self.notes = location.notes
        self.coordinate = location.coordinate
    }

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }

    func saveLocation() {
        guard let name = name else {
            return
        }
        if let existingLocation = location {
            let updatedLocation = ScenicPhotoLocation(name: name,
                                                      latitude: existingLocation.latitude,
                                                      longitude: existingLocation.longitude,
                                                      notes: notes)
            localStorage.updateLocation(updatedLocation)
            location = updatedLocation
        } else {
            let newLocation = ScenicPhotoLocation(name: name,
                                                  latitude: coordinate.latitude,
                                                  longitude: coordinate.longitude,
                                                  notes: notes)
            localStorage.createLocation(newLocation)
            location = newLocation
        }
    }

}
