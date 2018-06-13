//
//  LocationsListViewModelTests.swift
//  TakeHomeTestTests
//
//  Created by Andrew Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TakeHomeTest

class LocationsListViewModelTests: XCTestCase {

    var fakeLocations = [
        ScenicPhotoLocation(name: "Location 1", latitude: 1, longitude: 0, notes: "Notes 1"),
        ScenicPhotoLocation(name: "Location 2", latitude: 3, longitude: 0, notes: nil),
        ScenicPhotoLocation(name: "Location 3", latitude: 2, longitude: 0, notes: "Notes 3"),
        ScenicPhotoLocation(name: "Location 4", latitude: 0, longitude: 0, notes: nil)
    ]

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLocationsSortedAfterInitialization() {
        let fakeUserCoordinate = FakeUserCoordinateProvider()
        fakeUserCoordinate.userCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)

        let viewModel = LocationsListViewModel(locations: fakeLocations, userCoordinateProvider: fakeUserCoordinate)

        XCTAssertEqual(viewModel.locations[0], fakeLocations[3])
        XCTAssertEqual(viewModel.locations[1], fakeLocations[0])
        XCTAssertEqual(viewModel.locations[2], fakeLocations[2])
        XCTAssertEqual(viewModel.locations[3], fakeLocations[1])
    }

    func testLocationsNotSortedWhenUserCoordinateNil() {
        let fakeUserCoordinate = FakeUserCoordinateProvider()
        fakeUserCoordinate.userCoordinate = nil

        let viewModel = LocationsListViewModel(locations: fakeLocations, userCoordinateProvider: fakeUserCoordinate)

        XCTAssertEqual(viewModel.locations[0], fakeLocations[0])
        XCTAssertEqual(viewModel.locations[1], fakeLocations[1])
        XCTAssertEqual(viewModel.locations[2], fakeLocations[2])
        XCTAssertEqual(viewModel.locations[3], fakeLocations[3])
    }

}

class FakeUserCoordinateProvider: UserCoordinateProvider {
    var userCoordinate: CLLocationCoordinate2D?
}
