//
//  FilterCellViewModelTest.swift
//  FickrTests
//
//  Created by Shamas on 12/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import XCTest

@testable import Fickr

class FilterCellViewModelTest: XCTestCase {

    var filterCellViewModel: FilterCellViewModel!
    
    override func setUpWithError() throws {
        
        let filterModel = FilterObject(titleString: "2019 Photos", selected: true)
        filterCellViewModel = FilterCellViewModel(model: filterModel)
    }

    override func tearDownWithError() throws {
        
        filterCellViewModel = nil
    }
    
    func testFilterModel() throws {
        
        XCTAssertEqual(filterCellViewModel.getFilterLabel(), "2019 Photos")
        XCTAssertTrue(filterCellViewModel.isSelected())
    }

}
