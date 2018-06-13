//
//  MainViewModelTests.swift
//  TakeHomeTestTests
//
//  Created by Andrew Nester on 6/13/18.
//  Copyright © 2018 Globallogic Inc. All rights reserved.
//

import XCTest
@testable import TakeHomeTest

class MainViewModelTests: XCTestCase {

    var viewModel: MainViewModel!
    var fakeHttpService: LocationsFakeHttpService!
    var fakeStorage: ScenicPhotoLocationFakeStorage!
    var fakeUserDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        fakeHttpService = LocationsFakeHttpService()
        fakeUserDefaults = UserDefaults(suiteName: "fake")
        fakeUserDefaults.removePersistentDomain(forName: "fake")
        fakeStorage = ScenicPhotoLocationFakeStorage()
        viewModel = MainViewModel(httpService: fakeHttpService, storage: fakeStorage, userDefaults: fakeUserDefaults)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLocationsUpdatedClosureCalledOnPropertyUpdate() {
        let updateExpectation = expectation(description: "locationUpdate")
        viewModel.locationsUpdated = {
            updateExpectation.fulfill()
        }
        viewModel.fetchLocations()
        wait(for: [updateExpectation], timeout: 5)
    }

    func testFetchLocationsFetchesDefaultLocationsAtFirstLaunch() {
        fakeHttpService.isRequestScenicPhotoLocationsCalled = false
        viewModel.fetchLocations()
        XCTAssertTrue(fakeHttpService.isRequestScenicPhotoLocationsCalled)
    }

    func testFetchLocationsFetchesStoredLocationsEverytimeExeptFirstLaunch() {
        fakeStorage.isAllLocationsCalled = false
        viewModel.fetchLocations()
        XCTAssertFalse(fakeStorage.isAllLocationsCalled)
        viewModel.fetchLocations()
        XCTAssertTrue(fakeStorage.isAllLocationsCalled)
    }

    func testDidFailToFetchDefaultLocationClosureCalled() {
        fakeHttpService.returnError = NSError(domain: "fake", code: 1, userInfo: nil)
        let errorExpectation = expectation(description: "waitError")
        viewModel.didFailToFetchDefaultLocations = { error in
            XCTAssertEqual(error as NSError?, self.fakeHttpService.returnError as NSError?)
            errorExpectation.fulfill()
        }
        viewModel.fetchDefaultLocations()
        wait(for: [errorExpectation], timeout: 5)
    }

}
