//
//  FilterModel.swift
//  Fickr
//
//  Created by Shamas on 11/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

struct FilterObject {
    
    var title: String
    var isSelected: Bool
    
    init(titleString: String, selected: Bool = false) {
        title = titleString
        isSelected = selected
    }
}
