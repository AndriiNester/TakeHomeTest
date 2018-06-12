//
//  LocationDetailsViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class LocationDetailsViewModel {

    private(set) var location: ScenicPhotoLocation

    var name: String
    var description: String?
    var subtitle: String? // TODO: calculate distance

    init(location: ScenicPhotoLocation) {
        self.location = location
        self.name = location.name
        self.description = location.notes
    }

}
