//
//  FiltersViewModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class FiltersViewModel {
    
    private var filtersArray: [FilterObject] = []
    
    var onFiltersUpdated: (([FilterObject]) -> ())?
    
    init(allFilters: [FilterObject]) {
        filtersArray = allFilters
    }
    
    var rowCount: Int {
        return filtersArray.count
    }
    
    func getFilterViewModelFor(index: Int) -> FilterCellViewModel? {
        
        // just a precautionary index check
        guard index >= 0, index < filtersArray.count else {
            return nil
        }
        
        let model = filtersArray[index]        
        return FilterCellViewModel(model: model)
    }
    
    func updateSelectionAtIndex(selection: Bool, index: Int) {
        self.filtersArray[index].isSelected = selection
        onFiltersUpdated?(filtersArray)
    }
}
