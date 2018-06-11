//
//  MapViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/11/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class MapViewModel {

    let defaultLocations: [ScenicPhotoLocation]
    let userLocations: [ScenicPhotoLocation]

    var hasLocations: Bool {
        return !defaultLocations.isEmpty || !userLocations.isEmpty
    }

    init(defaultLocations: [ScenicPhotoLocation], userLocations: [ScenicPhotoLocation]) {
        self.defaultLocations = defaultLocations
        self.userLocations = userLocations
    }

}
