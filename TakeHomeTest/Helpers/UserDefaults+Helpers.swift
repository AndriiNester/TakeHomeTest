//
//  Helpers.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

extension UserDefaults {

    var hasFetchedDefaultLocations: Bool {
        let hasFetchedDefaultLocationsFlag = "hasFetchedDefaultLocations"
        let hasFetched = self.bool(forKey: hasFetchedDefaultLocationsFlag)
        if !hasFetched {
            self.set(true, forKey: hasFetchedDefaultLocationsFlag)
        }
        return hasFetched
    }

}
