//
//  FiltersViewModel.swift
//  Fickr
//
//  Created by Shamas on 10/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class FiltersViewModel {
    
    var filterModelsArray: [FilterModel] = []
    
    var setSelectedModels: (([FilterModel]) -> ())?
    
    init(allFilters: [FilterModel]) {
        filterModelsArray = allFilters
    }
    
    var rowCount: Int {
        return filterModelsArray.count
    }
    
    func getFilterViewModelForCell(index: Int) -> FilterCellViewModel? {
        
        // just a precautionary index check
        guard index > 0, index < filterModelsArray.count else {
            return nil
        }
        let model = filterModelsArray[index]
        
        let viewModel = FilterCellViewModel(model: model)
        viewModel.updateStateCallBack = { [weak self] model in
            self?.filterModelsArray[index] = model
        }
        return viewModel
    }
    
    func changedSelectionCellAtRow(selection: Bool, index: Int) {
        self.filterModelsArray[index].isSelected = selection
    }
    
    func viewDismissing() {
        setSelectedModels?(filterModelsArray)
    }
    
}
