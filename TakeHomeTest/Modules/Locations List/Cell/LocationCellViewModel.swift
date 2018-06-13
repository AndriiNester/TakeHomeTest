//
//  LocationCellViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationCellViewModel {

    let title: String
    let details: String
    let rightDetails: String?

    init(location: ScenicPhotoLocation, userCoordinate: CLLocationCoordinate2D?) {
        title = location.name
        if let notes = location.notes, !notes.isEmpty {
            details = notes
        } else {
            details = NSLocalizedString("no notes", comment: "Subtitle when cell is whithout notes")
        }
        rightDetails = userCoordinate?.formattedDistance(to: location.coordinate)
    }

}
