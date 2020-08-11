//
//  FiltersViewModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class FiltersViewModel {
    
    let filters: [String]
    let filterSet: Set<String>
    
    init(allFilters:Set<String>) {
        filterSet = allFilters
        filters = Array(filterSet).sorted()
    }
    
    var rowCount: Int {
        return filters.count
    }
    
    func getFilterViewModelForCell(index: Int) -> FilterCellViewModel? {
        
        // just a precautionary index check
        guard index > 0, index < filters.count else {
            return nil
        }
        
        let filter = FilterModel(titleString: filters[index])
        let viewModel = FilterCellViewModel(model: filter)
        return viewModel
    }
    
}
