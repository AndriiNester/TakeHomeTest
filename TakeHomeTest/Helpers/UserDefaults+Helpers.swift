//
//  Helpers.swift
//  TakeHomeTest
//
//  Created by Andrii Nester on 6/12/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import Foundation

extension UserDefaults {

    private static let hasFetchedDefaultLocationsFlag = "hasFetchedDefaultLocations"

    var hasFetchedDefaultLocations: Bool {
        get {
            return self.bool(forKey: UserDefaults.hasFetchedDefaultLocationsFlag)
        }
        set {
            self.set(newValue, forKey: UserDefaults.hasFetchedDefaultLocationsFlag)
        }
    }

}
