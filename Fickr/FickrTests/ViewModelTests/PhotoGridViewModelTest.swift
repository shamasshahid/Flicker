//
//  FickrTests.swift
//  FickrTests
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest
@testable import Fickr

class PhotoGridViewModelTest: XCTestCase {

    var viewModel: PhotoGridViewModel!
    let repository = MockRepository()
    
    override func setUpWithError() throws {
        
        viewModel = PhotoGridViewModel(apiService: repository.getAPIService(), locationManager: repository.getLocationService())
    }

    override func tearDownWithError() throws {
        
        viewModel = nil
    }
    
    func testAPI() throws {
        
        let searchExpectation = XCTestExpectation(description: "Request Fetching")
        viewModel.onDataRefreshed = {
            searchExpectation.fulfill()
        }
        
        viewModel.searchString = "testString"
        wait(for: [searchExpectation], timeout: 15)
        XCTAssertEqual(viewModel.rowCount, 4)
        
        let filterViewModel = viewModel.getFiltersVM()
        XCTAssertNotNil(filterViewModel, "filterViewModel should not be nil")
        
        let detailViewModel = viewModel.getDetailViewModelForIndex(index: 0)
        XCTAssertNotNil(detailViewModel, "detailViewModel should not be nil")
    }
    
    func testViewModelLocation() throws {
        
        let expecation = XCTestExpectation(description: "Location Fetching")
        viewModel.onDataRefreshed = {
            
            expecation.fulfill()
        }
        
        wait(for: [expecation], timeout: 30)

        
    }
    
}
