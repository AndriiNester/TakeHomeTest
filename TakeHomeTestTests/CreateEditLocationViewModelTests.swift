//
//  CreateEditLocationViewModelTests.swift
//  TakeHomeTestTests
//
//  Created by Andrii Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TakeHomeTest

class CreateEditLocationViewModelTests: XCTestCase {

    var fakeStorage: ScenicPhotoLocationFakeStorage!

    override func setUp() {
        super.setUp()
        fakeStorage = ScenicPhotoLocationFakeStorage()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIsSaveEnabledReturnsTrueIfNameNotEmpty() {
        let locationWithName = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: nil)
        let viewModel = CreateEditLocationViewModel(location: locationWithName)

        XCTAssertTrue(viewModel.isSaveEnabled)
    }

    func testIsSaveEnabledReturnsFalseIfNameEmpty() {
        let location = ScenicPhotoLocation(name: "", latitude: 1, longitude: 2, notes: nil)
        let viewModel = CreateEditLocationViewModel(location: location)
        viewModel.name = nil

        XCTAssertFalse(viewModel.isSaveEnabled)
    }

    func testIsSaveEnabledReturnsFalseIfNameNil() {
        let location = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: nil)
        let viewModel = CreateEditLocationViewModel(location: location)
        viewModel.name = nil

        XCTAssertFalse(viewModel.isSaveEnabled)
    }

    func testScreenTitleReturnedWhenEditMode() {
        let location = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: nil)
        let viewModel = CreateEditLocationViewModel(location: location)

        XCTAssertEqual(viewModel.screenTitle, "Edit Location")
    }

    func testScreenTitleReturnedWhenCreateMode() {
        let viewModel = CreateEditLocationViewModel(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))

        XCTAssertEqual(viewModel.screenTitle, "New Location")
    }

    func testSaveLocationDoesNothingWhenNameIsNil() {
        let viewModel = CreateEditLocationViewModel(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), storage: fakeStorage)
        viewModel.name = nil
        fakeStorage.isCreateLocationCalled = false
        fakeStorage.isUpdateLocationCalled = false

        viewModel.saveLocation()

        XCTAssertFalse(fakeStorage.isCreateLocationCalled)
        XCTAssertFalse(fakeStorage.isUpdateLocationCalled)
    }

    func testSaveLocationUpdatesLocationsWhenEditMode() {
        let location = ScenicPhotoLocation(name: "Name", latitude: 1, longitude: 2, notes: nil)
        let viewModel = CreateEditLocationViewModel(location: location, storage: fakeStorage)
        fakeStorage.isCreateLocationCalled = false
        fakeStorage.isUpdateLocationCalled = false

        viewModel.saveLocation()

        XCTAssertFalse(fakeStorage.isCreateLocationCalled)
        XCTAssertTrue(fakeStorage.isUpdateLocationCalled)
    }

    func testSaveLocationCreatesNewLocationWhenCreateMode() {
        let viewModel = CreateEditLocationViewModel(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), storage: fakeStorage)
        viewModel.name = "Name"
        fakeStorage.isCreateLocationCalled = false
        fakeStorage.isUpdateLocationCalled = false

        viewModel.saveLocation()

        XCTAssertTrue(fakeStorage.isCreateLocationCalled)
        XCTAssertFalse(fakeStorage.isUpdateLocationCalled)
    }

}
