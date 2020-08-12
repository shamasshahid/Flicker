//
//  FickrTests.swift
//  FickrTests
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest
@testable import Fickr

class FickrTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPI() throws {
        
        let viewModel = PhotoGridViewModel(apiService: MockAPIService(), cLocationManager: LocationManager())
        let expectation = self.expectation(description: "Data Fetching")
        viewModel.onDataRefreshed = {
            
            expectation.fulfill()
        }
        viewModel.searchString = "testString"
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.rowCount, 4)
        
        let cellViewModel = viewModel.getModelForIndex(index: 0)
        XCTAssertNotNil(cellViewModel, "Cell view Model should not be nil")
        
        let filterViewModel = viewModel.getFiltersVM()
        XCTAssertNotNil(filterViewModel, "filterViewModel should not be nil")
        
        let detailViewModel = viewModel.getDetailViewModelForIndex(index: 0)
        XCTAssertNotNil(detailViewModel, "detailViewModel should not be nil")
    }
    
}
