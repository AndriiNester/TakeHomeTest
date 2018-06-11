//
//  LocationsHTTPService.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation
import Alamofire

class LocationsRealHTTPService: LocationsHTTPService {

    private static let host = "http://bit.ly"

    func getScenicPhotoLocations(completion: @escaping (([ScenicPhotoLocation], Error?) -> Void)) {
        Alamofire.request("\(LocationsRealHTTPService.host)/test-locations").responseJSON { response in
            guard response.error == nil else {
                completion([], response.error)
                return
            }
            guard let json = response.result.value as? [String: Any],
                let locationsJson = json["locations"] as? [[String: Any]] else {
                completion([], nil)
                return
            }
            let locations: [ScenicPhotoLocation] = locationsJson.map {
                    guard let name = $0["name"] as? String,
                        let latitude = $0["lat"] as? Double,
                        let longitude = $0["lng"] as? Double else {
                        return nil
                    }
                return ScenicPhotoLocation(name: name, latitude: latitude, longitude: longitude, notes: nil)
                }.compactMap({ $0 })
            completion(locations, nil)
        }
    }

}
