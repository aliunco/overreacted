//
//  Date+Ext.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/21/23.
//

import Foundation

extension Date {
    func getDayBefore(count: Int) -> Date {
        guard count > 0 else { return self }
        return Calendar.current.date(byAdding: .day, value: -count, to: self) ?? self
    }
    
    func format(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
