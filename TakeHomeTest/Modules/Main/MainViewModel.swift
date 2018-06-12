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

    private(set) var locations: [ScenicPhotoLocation] = [] {
        didSet {
            locationsUpdated?()
        }
    }

    private let storage = ScenicPhotoLocationLocalStorage()

    init(httpService: LocationsHTTPService = LocationsRealHTTPService()) {
        self.httpService = httpService
    }

    func fetchLocations() {
        if UserDefaults.isFirstLaunch {
            fetchDefaultLocations()
        } else {
            fetchStoredLocations()
        }
    }

    func fetchDefaultLocations() {
        httpService.getScenicPhotoLocations { [weak self] locations, error in
            guard let _self = self else {
                return
            }
            guard error == nil else {
                _self.didFailToFetchDefaultLocations?(error)
                return
            }
            _self.locations = locations
            locations.forEach {
                _self.storage.createLocation($0)
            }
        }
    }

    func fetchStoredLocations() {
        locations = storage.getAllLocations()
    }

}
