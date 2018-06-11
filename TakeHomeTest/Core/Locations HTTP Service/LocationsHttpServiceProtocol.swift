//
//  LocationsHTTPServiceProtocol.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

protocol LocationsHTTPService {

    /**
     Fetches list of default scenic photo locations
     - parameter completion: Result of the request is sent to this completion handler
     */
    func getScenicPhotoLocations(completion: @escaping (([ScenicPhotoLocation], Error?) -> Void))

}
