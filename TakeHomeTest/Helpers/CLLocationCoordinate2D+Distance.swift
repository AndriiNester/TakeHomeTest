//
//  CLLocationCoordinate2D+Distance.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {

    func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1 = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let location2 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return location1.distance(from: location2)
    }

    func formattedDistance(to coordinate: CLLocationCoordinate2D) -> String {
        let distance = self.distance(to: coordinate)
        let formatter = MKDistanceFormatter()
        return formatter.string(fromDistance: distance)
    }

}
