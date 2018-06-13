//
//  LocationDetailsViewModelTests.swift
//  TakeHomeTestTests
//
//  Created by Andrew Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TakeHomeTest

class LocationDetailsViewModelTests: XCTestCase {

    let locationWithNotes = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: "Notes")
    let locationWithoutNotes = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: nil)
    let locationWithEmptyNotes = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: "")

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNameEqualsToLocationName() {
        let viewModel = LocationDetailsViewModel(location: locationWithNotes, userCoordinateProvider: nil)

        XCTAssertEqual(viewModel.name, locationWithNotes.name)
    }

    func testDetailsEqualsToLocationNotes() {
        let viewModel = LocationDetailsViewModel(location: locationWithNotes, userCoordinateProvider: nil)

        XCTAssertEqual(viewModel.notes, locationWithNotes.notes)
    }

    func testDetailsEqualsToPlaceholderWhenLocationNotesNil() {
        let viewModel = LocationDetailsViewModel(location: locationWithoutNotes, userCoordinateProvider: nil)

        XCTAssertEqual(viewModel.notes, "This location has no notes.")
    }

    func testDetailsEqualsToPlaceholderWhenLocationNotesEmpty() {
        let viewModel = LocationDetailsViewModel(location: locationWithEmptyNotes, userCoordinateProvider: nil)

        XCTAssertEqual(viewModel.notes, "This location has no notes.")
    }

    func testRightDetailsEqualsToFormattedDistance() {
        let fakeCoordinateProvider = FakeUserCoordinateProvider()
        fakeCoordinateProvider.userCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 1)

        let viewModel = LocationDetailsViewModel(location: locationWithNotes, userCoordinateProvider: fakeCoordinateProvider)

        let locationCoordinate = locationWithNotes.coordinate
        XCTAssertEqual(viewModel.subtitle, fakeCoordinateProvider.userCoordinate?.formattedDistance(to: locationCoordinate))
    }

    func testCreateEditLocationViewModelCreatedWithSameLocation() {
        let viewModel = LocationDetailsViewModel(location: locationWithNotes, userCoordinateProvider: nil)
        let createEditViewModel = viewModel.createEditLocationViewModel

        XCTAssertEqual(createEditViewModel.location, locationWithNotes)
    }

}
