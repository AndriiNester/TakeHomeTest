//
//  CreateEditLocationViewModel.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

class CreateEditLocationViewModel {

    private(set) var location: ScenicPhotoLocation?

    var name: String?
    var description: String?

    var isSaveEnabled: Bool {
        return name != nil && name?.isEmpty == false
    }

    init(location: ScenicPhotoLocation? = nil) {
        self.location = location
        self.name = location?.name
        self.description = location?.description
    }

}
