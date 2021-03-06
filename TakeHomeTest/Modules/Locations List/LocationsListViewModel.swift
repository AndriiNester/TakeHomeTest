//
//  LocationsListViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import CoreLocation

class LocationsListViewModel {

    var locations: [ScenicPhotoLocation]
    let userCoordinate: CLLocationCoordinate2D?

    init(locations: [ScenicPhotoLocation], userCoordinateProvider: UserCoordinateProvider = CLLocationManager()) {
        self.locations = locations
        self.userCoordinate = userCoordinateProvider.userCoordinate
        sortLocations()
    }

    // MARK: - Private

    private func sortLocations() {
        guard let userCoordinate = userCoordinate else {
            return
        }
        locations = locations.sorted(by: { location1, location2 in
            return location1.coordinate.distance(to: userCoordinate) < location2.coordinate.distance(to: userCoordinate)
        })
    }

}
