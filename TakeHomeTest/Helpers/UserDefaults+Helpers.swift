//
//  Helpers.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

extension UserDefaults {

    static var hasFetchedDefaultLocations: Bool {
        let hasFetchedDefaultLocationsFlag = "hasFetchedDefaultLocations"
        let hasFetched = UserDefaults.standard.bool(forKey: hasFetchedDefaultLocationsFlag)
        if !hasFetched {
            UserDefaults.standard.set(true, forKey: hasFetchedDefaultLocationsFlag)
        }
        return hasFetched
    }

}
