//
//  Date+Extension.swift
//  Fickr
//
//  Created by Shamas on 13/8/20.
//  Copyright © 2020 Shamas. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /// It expect the date to be in "2020-08-10 04:32:11" fomat
    static let longDateFormatReader: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    /// Prints the date n 
    static let mediumDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
}
