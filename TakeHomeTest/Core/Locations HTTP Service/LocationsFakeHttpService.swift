//
//  LocationsFakeHttpService.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class LocationsFakeHttpService: LocationsHTTPService {

    var returnCoordinates: [ScenicPhotoLocation]? = [
        ScenicPhotoLocation(name: "Location 1", latitude: 40.759011, longitude: -73.984472, notes: "Notes 1"),
        ScenicPhotoLocation(name: "Location 2", latitude: 40.748441, longitude: -73.985564, notes: nil),
        ScenicPhotoLocation(name: "Location 3", latitude: 40.748441, longitude: -73.989564, notes: "Notes 3"),
        ScenicPhotoLocation(name: "Location 4", latitude: 40.758441, longitude: -73.992564, notes: nil)
    ]

    var returnError: Error?
    var isRequestScenicPhotoLocationsCalled: Bool = false

    func requestScenicPhotoLocations(completion: @escaping (([ScenicPhotoLocation]?, Error?) -> Void)) {
        isRequestScenicPhotoLocationsCalled = true
        completion(returnCoordinates, returnError)
    }

}
