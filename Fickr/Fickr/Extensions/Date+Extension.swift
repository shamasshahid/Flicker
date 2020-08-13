//
//  Date+Extension.swift
//  Fickr
//
//  Created by Shamas on 13/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let longDateFormatReader: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static let shortDateStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
}
