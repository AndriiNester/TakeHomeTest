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
    var description: String?
    let coordinate: CLLocationCoordinate2D

    var isSaveEnabled: Bool {
        return name != nil && name?.isEmpty == false
    }

    private let localStorage = ScenicPhotoLocationLocalStorage()

    init(location: ScenicPhotoLocation) {
        self.location = location
        self.name = location.name
        self.description = location.notes
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
                                                      notes: description)
            localStorage.updateLocation(updatedLocation)
            location = updatedLocation
        } else {
            let newLocation = ScenicPhotoLocation(name: name,
                                                  latitude: coordinate.latitude,
                                                  longitude: coordinate.longitude,
                                                  notes: description)
            localStorage.createLocation(newLocation)
            location = newLocation
        }
    }

}
