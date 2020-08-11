//
//  FilterCellViewModel.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class FilterCellViewModel {
    
    var filterModel: FilterModel
    
    var updateViewCallBack: (() -> Void)?
    var updateStateCallBack: ((FilterModel) -> Void)?
    
    init(model: FilterModel) {
        
        filterModel = model
    }
    
    func getFilterLabel() -> String {
        return filterModel.title
    }
    
    func isSelected() -> Bool {
        return filterModel.isSelected
    }
    
    func selectionChanged(isSelected: Bool) {
        filterModel.isSelected = isSelected
        updateStateCallBack?(filterModel)
        updateViewCallBack?()
    }
    
}
