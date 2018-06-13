//
//  LocationCellViewModelTests.swift
//  TakeHomeTestTests
//
//  Created by Andrew Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TakeHomeTest

class LocationCellViewModelTests: XCTestCase {

    let locationWithNotes = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: "Notes")
    let locationWithoutNotes = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: nil)
    let locationWithEmptyNotes = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: "")

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTitleEqualsToLocationName() {
        let viewModel = LocationCellViewModel(location: locationWithNotes, userCoordinate: nil)
        XCTAssertEqual(viewModel.title, locationWithNotes.name)
    }

    func testDetailsEqualsToLocationNotes() {
        let viewModel = LocationCellViewModel(location: locationWithNotes, userCoordinate: nil)
        XCTAssertEqual(viewModel.details, locationWithNotes.notes)
    }

    func testDetailsEqualsToPlaceholderWhenLocationNotesNil() {
        let viewModel = LocationCellViewModel(location: locationWithoutNotes, userCoordinate: nil)
        XCTAssertEqual(viewModel.details, "no notes")
    }

    func testDetailsEqualsToPlaceholderWhenLocationNotesEmpty() {
        let viewModel = LocationCellViewModel(location: locationWithEmptyNotes, userCoordinate: nil)
        XCTAssertEqual(viewModel.details, "no notes")
    }

    func testRightDetailsEqualsToFormattedDistance() {
        let userCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 1)
        let viewModel = LocationCellViewModel(location: locationWithNotes, userCoordinate: userCoordinate)
        let locationCoordinate = locationWithNotes.coordinate
        XCTAssertEqual(viewModel.rightDetails, userCoordinate.formattedDistance(to: locationCoordinate))
    }

}
