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
    private let storage: Storage
    private let userDefaults: UserDefaults

    private(set) var locations: [ScenicPhotoLocation] = [] {
        didSet {
            locationsUpdated?()
        }
    }

    init(httpService: LocationsHTTPService = LocationsRealHTTPService(), storage: Storage = UserDefaultsStorage(), userDefaults: UserDefaults = UserDefaults.standard) {
        self.httpService = httpService
        self.storage = storage
        self.userDefaults = userDefaults
    }

    func fetchLocations() {
        fetchStoredLocations()
        // fetch default only one time and save them into storage for future use
        if !userDefaults.hasFetchedDefaultLocations {
            fetchDefaultLocations()
        }
    }

    func fetchStoredLocations() {
        locations = storage.allObjects()
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
            _self.locations += locations ?? []
            locations?.forEach {
                _self.storage.create($0)
            }
            _self.userDefaults.hasFetchedDefaultLocations = true
        }
    }

}
