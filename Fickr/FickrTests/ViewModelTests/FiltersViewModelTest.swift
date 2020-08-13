//
//  FiltersViewModelTest.swift
//  FickrTests
//
//  Created by Shamas on 12/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import Fickr

class FiltersViewModelTest: XCTestCase {

    var filtersViewModel: FiltersViewModel!
    
    override func setUpWithError() throws {
        
        let filtersArray = [FilterObject(titleString: "filter 1", selected: true),
                            FilterObject(titleString: "filter 2", selected: true),
                            FilterObject(titleString: "filter 3", selected: false),
                            FilterObject(titleString: "filter 4", selected: false)]
                            
        filtersViewModel = FiltersViewModel(allFilters: filtersArray)
    }

    override func tearDownWithError() throws {
        filtersViewModel = nil
    }
    
    func testFilterViewModel() {
        
        XCTAssertEqual(filtersViewModel.rowCount, 4)
        
        let filterExpectation = XCTestExpectation(description: "Updating Filter")
        
        filtersViewModel.onFiltersUpdated = { filters in
            filterExpectation.fulfill()
        
            let viewModel = self.filtersViewModel.getFilterViewModelFor(index: 3)
            
            XCTAssertNotNil(viewModel)
            XCTAssertTrue(viewModel!.isSelected())
        }
        
        filtersViewModel.updateSelectionAtIndex(selection: true, index: 3)
        
        let incorrectModel = filtersViewModel.getFilterViewModelFor(index: 4)
        XCTAssertNil(incorrectModel)
        
        wait(for: [filterExpectation], timeout: 5)

    }
    
    func testResetAllFilters() {
        
        let filterResetExpectation = XCTestExpectation(description: "Resetting Filters")
        filtersViewModel.onFilterReset = {
            
            filterResetExpectation.fulfill()
            let viewModel = self.filtersViewModel.getFilterViewModelFor(index: 0)
            
            XCTAssertNotNil(viewModel)
            XCTAssertFalse(viewModel!.isSelected())
        }
        filtersViewModel.resetAllFilters()
        wait(for: [filterResetExpectation], timeout: 5)

    }

}
