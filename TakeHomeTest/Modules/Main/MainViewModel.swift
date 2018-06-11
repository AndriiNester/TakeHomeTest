//
//  MainViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class MainViewModel {

    var locationsUpdated: (() -> Void)?
    var didFailToFetchDefaultLocations: ((Error?) -> Void)?
    var didFailToFetchUserLocations: ((Error?) -> Void)?

    private let httpService: LocationsHTTPService

    private(set) var defaultLocations: [ScenicPhotoLocation] = [] {
        didSet {
            locationsUpdated?()
        }
    }

    private(set) var userLocations: [ScenicPhotoLocation] = [] {
        didSet {
            locationsUpdated?()
        }
    }

    init(httpService: LocationsHTTPService = LocationsRealHTTPService()) {
        self.httpService = httpService
    }

    func fetchDefaultLocations() {
        httpService.getScenicPhotoLocations { [weak self] locations, error in
            guard error == nil else {
                self?.didFailToFetchDefaultLocations?(error)
                return
            }
            self?.defaultLocations = locations
        }
    }

    func fetchUserLocations() {
        fatalError("not implemented yet")
    }

}
