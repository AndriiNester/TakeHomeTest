//
//  LocationDetailsViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import CoreLocation

class LocationDetailsViewModel {

    private(set) var location: ScenicPhotoLocation

    var name: String
    var notes: String?
    var subtitle: String?

    private let emptyDescriptionPlaceholder = NSLocalizedString("This location has no notes.", comment: "Notes placeholder")

    var createEditLocationViewModel: CreateEditLocationViewModel {
        return CreateEditLocationViewModel(location: location)
    }

    init(location: ScenicPhotoLocation) {
        self.location = location
        self.name = location.name
        self.notes = location.notes?.isEmpty == false ? location.notes : emptyDescriptionPlaceholder
        self.subtitle = CLLocationManager().location?.coordinate.formattedDistance(to: location.coordinate)
    }

}
