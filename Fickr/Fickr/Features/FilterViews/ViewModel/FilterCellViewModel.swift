//
//  FilterCellViewModel.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

class FilterCellViewModel {
    
    private var filter: FilterObject
    
    var onFilterStateChanged: (() -> Void)?
    
    init(model: FilterObject) {
        
        filter = model
    }
    
    func getFilterLabel() -> String {
        return filter.title
    }
    
    func isSelected() -> Bool {
        return filter.isSelected
    }
    
    func selectionChanged(isSelected: Bool) {
        filter.isSelected = isSelected
        onFilterStateChanged?()
    }
    
}
