//
//  Date+Ext.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/21.
//

import Foundation

extension Date {
    var eighteenYearsAgo: Date {
        guard let date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) else {
            return Date()
        }
        return date
    }
    
    var oneHundredTenYearsAgo: Date {
        guard let date = Calendar.current.date(byAdding: .year, value: -110, to: Date()) else {
            return Date()
        }
        return date
    }

}
