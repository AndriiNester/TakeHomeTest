//
//  ScenicPhotoLocation.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import MapKit

class ScenicPhotoLocation: NSObject, Codable {

    let name: String
    let latitude: Double
    let longitude: Double
    let notes: String?

    init(name: String, latitude: Double, longitude: Double, notes: String? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
    }

}

extension ScenicPhotoLocation: StorageObject {

    var storageId: String {
        return "\(latitude),\(longitude)"
    }

}

extension ScenicPhotoLocation: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var title: String? {
        return name
    }

}
