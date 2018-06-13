//
//  MapViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import CoreLocation

class MapViewModel {

    let locations: [ScenicPhotoLocation]

    var hasLocations: Bool {
        return !locations.isEmpty
    }

    init(locations: [ScenicPhotoLocation]) {
        self.locations = locations
    }

}
