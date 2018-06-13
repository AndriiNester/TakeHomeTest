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

    let host: String

    private static let defaultHost = "http://bit.ly"

    private struct LocationsResponse: Codable {
        var locations: [ScenicPhotoLocation] = []
    }

    init(host: String = LocationsRealHTTPService.defaultHost) {
        self.host = host
    }

    func requestScenicPhotoLocations(completion: @escaping (([ScenicPhotoLocation]?, Error?) -> Void)) {
        Alamofire.request("\(host)/test-locations").responseJSON { response in
            guard response.error == nil else {
                completion([], response.error)
                return
            }

            guard let data = response.data else {
                completion(nil, nil)
                return
            }
            let locationsResponse = try? JSONDecoder().decode(LocationsResponse.self, from: data)
            completion(locationsResponse?.locations, nil)
        }
    }

}
