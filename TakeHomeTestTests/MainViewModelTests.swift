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
    var fakeStorage: FakeStorage!
    var fakeUserDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        fakeHttpService = LocationsFakeHttpService()
        fakeUserDefaults = UserDefaults(suiteName: "fake")
        fakeUserDefaults.removePersistentDomain(forName: "fake")
        fakeStorage = FakeStorage()
        viewModel = MainViewModel(httpService: fakeHttpService, storage: fakeStorage, userDefaults: fakeUserDefaults)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLocationsUpdatedClosureCalledOnPropertyUpdate() {
        let updateExpectation = expectation(description: "locationUpdate")
        updateExpectation.expectedFulfillmentCount = 2
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

    func testFetchLocationsFetchesStoredLocations() {
        fakeStorage.isAllObjectsCalled = false
        viewModel.fetchLocations()
        XCTAssertTrue(fakeStorage.isAllObjectsCalled)
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
