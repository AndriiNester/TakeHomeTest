//
//  UserCoordinateProvider.swift
//  TakeHomeTest
//
//  Created by Andrew Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import CoreLocation

protocol UserCoordinateProvider {
    var userCoordinate: CLLocationCoordinate2D? { get }
}

extension CLLocationManager: UserCoordinateProvider {

    var userCoordinate: CLLocationCoordinate2D? {
        return location?.coordinate
    }

}
