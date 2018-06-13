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

    private let httpService: LocationsHTTPService
    private let storage: ScenicPhotoLocationStorage
    private let userDefaults: UserDefaults

    private(set) var locations: [ScenicPhotoLocation] = [] {
        didSet {
            locationsUpdated?()
        }
    }

    init(httpService: LocationsHTTPService = LocationsRealHTTPService(), storage: ScenicPhotoLocationStorage = ScenicPhotoLocationLocalStorage(), userDefaults: UserDefaults = UserDefaults.standard) {
        self.httpService = httpService
        self.storage = storage
        self.userDefaults = userDefaults
    }

    func fetchLocations() {
        if !userDefaults.hasFetchedDefaultLocations {
            fetchDefaultLocations()
        } else {
            fetchStoredLocations()
        }
    }

    func fetchDefaultLocations() {
        httpService.requestScenicPhotoLocations { [weak self] locations, error in
            guard let _self = self else {
                return
            }
            guard error == nil else {
                _self.didFailToFetchDefaultLocations?(error)
                return
            }
            _self.locations = locations ?? []
            locations?.forEach {
                _self.storage.createLocation($0)
            }
        }
    }

    func fetchStoredLocations() {
        locations = storage.getAllLocations()
    }

}
